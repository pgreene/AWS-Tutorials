resource "aws_launch_configuration" "main" {
  name_prefix   = "${var.tr_env}-${var.app_name}-${var.tr_region}-LaunchConfig"
  image_id      = "${data.aws_ami.recent_ami.image_id}"
  instance_type = "${var.instance_type}"

  user_data = "${data.template_file.user_data.rendered}"

  //user_data = "${var.user_data != "" ?  var.user_data : data.template_file.user_data.rendered}"

  enable_monitoring = "${var.enable_monitoring}"
  security_groups = [
    "${compact(concat(list(aws_security_group.main.id), split(",", "${var.security_group_ids}")))}",
  ]
  iam_instance_profile        = "${aws_iam_instance_profile.iam_profile.name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  lifecycle {
    create_before_destroy = true
  }
  depends_on = ["aws_iam_role.a_role", "aws_iam_role_policy.a_policy"]
}

resource "aws_autoscaling_group" "main" {
  name                = "${var.tr_env}-${var.app_name}-${var.tr_region}-ASG"
  vpc_zone_identifier = ["${data.aws_subnet_ids.private.ids}"]

  desired_capacity          = "1"
  min_size                  = "1"
  max_size                  = "1"
  health_check_grace_period = "60"
  health_check_type         = "EC2"
  force_delete              = false
  wait_for_capacity_timeout = 0
  launch_configuration      = "${aws_launch_configuration.main.name}"

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
    value               = "${var.tr_env}-${var.app_name}-${var.tr_region}"
    propagate_at_launch = true
  }

  tag {
    key                 = "traderev:automation"
    value               = "${var.automation}"
    propagate_at_launch = true
  }

  tag {
    key                 = "traderev:environment"
    value               = "${var.tr_env}"
    propagate_at_launch = true
  }

  tag {
    key                 = "traderev:region"
    value               = "${var.tr_region}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_launch_configuration.main"]
}
