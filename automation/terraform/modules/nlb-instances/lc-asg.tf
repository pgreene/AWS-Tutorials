// -----------------------------------------------------------
// LC
// SPOT
// -----------------------------------------------------------
resource "aws_launch_configuration" "launch_config_spot" {
  name_prefix = "${var.pr_env}-${var.project_name}-${var.pr_region}-LaunchConfig-Spot"

  // image_id                    = "${var.ami_id != "" ?  var.ami_id : data.aws_ami.recent_ami.image_id}"
  image_id                    = "${data.aws_ami.recent_ami.image_id}"
  instance_type               = "${var.instance_type_spot}"
  iam_instance_profile        = "${aws_iam_instance_profile.iam_profile.name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"

  //user_data = "${var.user_data != "" ?  var.user_data : data.template_file.user_data.rendered}"
  user_data         = "${data.template_file.user_data.rendered}"
  enable_monitoring = "${var.enable_monitoring}"
  security_groups   = ["${aws_security_group.main.id}"]

  spot_price = "0.060"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_iam_role.a_role", "aws_iam_role_policy.a_policy"]
}

// -----------------------------------------------------------
// LC
// ON DEMAND
// -----------------------------------------------------------
resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "${var.pr_env}-${var.project_name}-${var.pr_region}-LaunchConfig"
  image_id                    = "${data.aws_ami.recent_ami.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${aws_iam_instance_profile.iam_profile.name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  user_data                   = "${data.template_file.user_data.rendered}"
  enable_monitoring           = "${var.enable_monitoring}"
  security_groups             = ["${aws_security_group.main.id}"]

  iam_instance_profile = "${aws_iam_instance_profile.iam_profile.name}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_iam_role.a_role", "aws_iam_role_policy.a_policy"]
}

// -----------------------------------------------------------
// AUTOSCALING GROUP
// SPOT
// We want this to explicitly depend on the SPOT launch config above
// -----------------------------------------------------------
resource "aws_autoscaling_group" "main_asg_spot" {
  // name = "${var.asg_name}"
  name                = "${var.pr_env}-${var.project_name}-${var.pr_region}-ASG-SPOT"
  vpc_zone_identifier = ["${data.aws_subnet_ids.private.ids}"]

  //availability_zones  = ["${data.aws_availability_zones.available.names[1]}"]

  // Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config_spot.id}"
  //enabled_metrics = "${var.enabled_metrics}"
  max_size                  = "${var.spot_max_size}"
  min_size                  = "${var.spot_min_size}"
  desired_capacity          = "${var.spot_desired_capacity}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  wait_for_capacity_timeout = "${var.wait_capacity}"
  termination_policies      = ["Default"]
  target_group_arns         = ["${aws_alb_target_group.front_end.id}"]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
  tag {
    key                 = "Name"
    value               = "${var.pr_env}-${var.project_name}-${var.pr_region}"
    propagate_at_launch = true
  }
  tag {
    key                 = "automation"
    value               = "${var.automation}"
    propagate_at_launch = true
  }
  tag {
    key                 = "environment"
    value               = "${var.pr_env}"
    propagate_at_launch = true
  }
  tag {
    key                 = "region"
    value               = "${var.pr_region}"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_launch_configuration.launch_config_spot", "aws_alb_target_group.front_end"]
}

// -----------------------------------------------------------
// AUTOSCALING GROUP
// ON DEMAND
// We want this to explicitly depend on the ON DEMAND launch config above
// -----------------------------------------------------------
resource "aws_autoscaling_group" "main_asg" {
  name                = "${var.pr_env}-${var.project_name}-${var.pr_region}-ASG"
  vpc_zone_identifier = ["${data.aws_subnet_ids.private.ids}"]

  //availability_zones  = ["${data.aws_availability_zones.available.names[1]}"]

  // Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config.id}"
  //enabled_metrics = "${var.enabled_metrics}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.desired_capacity}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  wait_for_capacity_timeout = "${var.wait_capacity}"
  termination_policies      = ["Default"]
  target_group_arns         = ["${aws_alb_target_group.front_end.id}"]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
  tag {
    key                 = "Name"
    value               = "${var.pr_env}-${var.project_name}-${var.pr_region}"
    propagate_at_launch = true
  }
  tag {
    key                 = "automation"
    value               = "${var.automation}"
    propagate_at_launch = true
  }
  tag {
    key                 = "environment"
    value               = "${var.pr_env}"
    propagate_at_launch = true
  }
  tag {
    key                 = "region"
    value               = "${var.pr_region}"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_launch_configuration.launch_config", "aws_alb_target_group.front_end"]
}

//resource "aws_autoscaling_policy" "add_capacity" {
//  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-ADD"
//  adjustment_type        = "${var.adjustment_type}"
//  autoscaling_group_name = "${aws_autoscaling_group.main_asg.name}"
//  policy_type            = "${var.policy_type}"
//  metric_aggregation_type = "${var.metric_aggregation_type}"

//  step_adjustment {
//    metric_interval_upper_bound = 5
//    metric_interval_lower_bound = 0
//    scaling_adjustment          = 5
//    }
//  step_adjustment {
//    metric_interval_upper_bound = 10
//    metric_interval_lower_bound = 5
//    scaling_adjustment          = 15
//    }

//  step_adjustment {
//    metric_interval_lower_bound = 10
//    scaling_adjustment          = 30
//    }
//}

// -----------------------------------------------------------
// Cloudwatch and Autoscaling Policies CPU Utilization
// SPOT
// -----------------------------------------------------------
resource "aws_autoscaling_policy" "add_capacity_spot" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-ADD-SPOT"
  scaling_adjustment     = "${var.add_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type_spot}"
  cooldown               = "${var.cooldown_spot}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg_spot.name}"
}

resource "aws_cloudwatch_metric_alarm" "add_capacity_spot" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-CPU-ADD-SPOT"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods_spot}"
  metric_name         = "${var.cpu_metric_name}"
  namespace           = "${var.namespace_spot}"
  period              = "${var.period_spot}"
  statistic           = "${var.statistic_spot}"
  threshold           = "${var.add_threshold}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg_spot.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization increase"
  alarm_actions     = ["${aws_autoscaling_policy.add_capacity_spot.arn}"]
}

resource "aws_autoscaling_policy" "reduce_capacity_spot" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-REDUCE-SPOT"
  scaling_adjustment     = "${var.reduce_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type_spot}"
  cooldown               = "${var.cooldown_spot}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg_spot.name}"
}

resource "aws_cloudwatch_metric_alarm" "reduce_capacity_spot" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-CPU-REDUCE-SPOT"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods_spot}"
  metric_name         = "${var.cpu_metric_name}"
  namespace           = "${var.namespace_spot}"
  period              = "${var.period_spot}"
  statistic           = "${var.statistic_spot}"
  threshold           = "${var.reduce_threshold}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg_spot.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization reduction"
  alarm_actions     = ["${aws_autoscaling_policy.reduce_capacity_spot.arn}"]
}

// -----------------------------------------------------------
// Cloudwatch and Autoscaling Policies CPU Utilization
// ON DEMAND
// -----------------------------------------------------------
resource "aws_autoscaling_policy" "add_capacity" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-ADD"
  scaling_adjustment     = "${var.add_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type}"
  cooldown               = "${var.cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "add_capacity" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-CPU-ADD"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.cpu_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.add_threshold}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization increase"
  alarm_actions     = ["${aws_autoscaling_policy.add_capacity.arn}"]
}

resource "aws_autoscaling_policy" "reduce_capacity" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-REDUCE"
  scaling_adjustment     = "${var.reduce_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type}"
  cooldown               = "${var.cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "reduce_capacity" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-CPU-REDUCE"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.cpu_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.reduce_threshold}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization reduction"
  alarm_actions     = ["${aws_autoscaling_policy.reduce_capacity.arn}"]
}

// -----------------------------------------------------------
// Autoscaling Policy & Cloudwatch NETWORK
// SPOT
// -----------------------------------------------------------
resource "aws_autoscaling_policy" "add_capacity_net_spot" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-NET-ADD-SPOT"
  scaling_adjustment     = "${var.add_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type_spot}"
  cooldown               = "${var.cooldown_spot}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg_spot.name}"
}

resource "aws_cloudwatch_metric_alarm" "add_capacity_net_spot" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-NET-ADD-SPOT"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods_spot}"
  metric_name         = "${var.net_metric_name}"
  namespace           = "${var.namespace_spot}"
  period              = "${var.period_spot}"
  statistic           = "${var.statistic_net_spot}"
  threshold           = "${var.add_threshold_net}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg_spot.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization increase"
  alarm_actions     = ["${aws_autoscaling_policy.add_capacity_net_spot.arn}"]
}

resource "aws_autoscaling_policy" "reduce_capacity_net_spot" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-NET-REDUCE-SPOT"
  scaling_adjustment     = "${var.reduce_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type_spot}"
  cooldown               = "${var.cooldown_spot}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg_spot.name}"
}

resource "aws_cloudwatch_metric_alarm" "reduce_capacity_net_spot" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-NET-REDUCE-SPOT"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods_spot}"
  metric_name         = "${var.net_metric_name}"
  namespace           = "${var.namespace_spot}"
  period              = "${var.period_spot}"
  statistic           = "${var.statistic_net_spot}"
  threshold           = "${var.reduce_threshold_net}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg_spot.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization reduction"
  alarm_actions     = ["${aws_autoscaling_policy.reduce_capacity_net_spot.arn}"]
}

// -----------------------------------------------------------
// Autoscaling Policy & Cloudwatch NETWORK
// ON DEMAND
// -----------------------------------------------------------
resource "aws_autoscaling_policy" "add_capacity_net" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-NET-ADD"
  scaling_adjustment     = "${var.add_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type_spot}"
  cooldown               = "${var.cooldown_spot}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "add_capacity_net" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-NET-ADD"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.net_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic_net}"
  threshold           = "${var.add_threshold_net}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg.name}"
  }

  alarm_description = "This metric monitors ec2 network utilization increase"
  alarm_actions     = ["${aws_autoscaling_policy.add_capacity_net.arn}"]
}

resource "aws_autoscaling_policy" "reduce_capacity_net" {
  name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-NET-REDUCE"
  scaling_adjustment     = "${var.reduce_scaling_adjustment}"
  adjustment_type        = "${var.adjustment_type}"
  cooldown               = "${var.cooldown}"
  autoscaling_group_name = "${aws_autoscaling_group.main_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "reduce_capacity_net" {
  alarm_name          = "${var.pr_env}-${var.project_name}-${var.pr_region}-ALRM-NET-REDUCE"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.net_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic_net}"
  threshold           = "${var.reduce_threshold_net}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main_asg.name}"
  }

  alarm_description = "This metric monitors ec2 network utilization reduction"
  alarm_actions     = ["${aws_autoscaling_policy.reduce_capacity_net.arn}"]
}
