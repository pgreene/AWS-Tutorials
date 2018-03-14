resource "aws_alb" "front_end" {
  name    = "${var.tr_env}-${var.app_name}-${var.tr_region}-LB"
  subnets = ["${data.aws_subnet_ids.public.ids}"]

  //security_groups = ["${aws_security_group.main_security_group.id}"]
  internal           = "${var.alb_is_internal}"
  load_balancer_type = "${var.load_balancer_type}"

  //access_logs {
  //  bucket = "${var.tr_env}-${var.app_name}-${var.tr_region}-BKT"
  //  prefix = "log"
  //}
  tags = {
    "Name"                 = "${var.tr_env}-${var.app_name}-${var.tr_region}-LB"
    "traderev:automation"  = "${var.automation}"
    "traderev:environment" = "${var.tr_env}"
    "traderev:region"      = "${var.tr_region}"
  }

  depends_on = ["aws_iam_role.a_role", "aws_iam_role_policy.a_policy", "aws_security_group.main"]
}

//resource "aws_s3_bucket" "log_bucket" {
//  bucket        = "${var.tr_env}-${var.app_name}-${var.tr_region}-BKT"
//  policy =<<POLICY
//{
//  "Version": "2012-10-17",
//  "Id": "S3BKTTPOLICY",
//  "Statement": [
//    {
//      "Sid": "IPAllow",
//      "Effect": "Deny",
//      "Principal": "*",
//      "Action": "s3:*",
//      "Resource": "arn:aws:s3:::${var.tr_env}-${var.app_name}-${var.tr_region}-BKT/*",
//      "Condition": {
//         "IpAddress": {"aws:SourceIp": "0.0.0.0/32"}
//      } 
//    } 
//  ]
//}
//POLICY

//  force_destroy = true
//  tags = {
//  "Name" = "${var.tr_env}-${var.app_name}-${var.tr_region}-BKT"
//  "traderev:automation"="${var.automation}"
//  "traderev:environment"="${var.tr_env}"
//  "traderev:region"="${var.tr_region}"
//  }
//}

resource "aws_alb_target_group" "front_end" {
  name     = "${var.tr_env}-${var.app_name}-${var.tr_region}-TG"
  port     = "${var.backend_port}"
  protocol = "${upper(var.backend_protocol)}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval = "${var.interval}"

    //path                = "${var.health_check_path}"
    port                = "${var.health_check_port}"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"

    //timeout             = "${var.timeout}"
    protocol = "${var.health_check_protocol}"

    //matcher             = "${var.backend_port}"
  }

  //stickiness {
  //  type            = "lb_cookie"
  //  cookie_duration = "${var.cookie_duration}"
  //  enabled         = "${ var.cookie_duration == 1 ? false : true}"
  //}
  tags = {
    "Name"                 = "${var.tr_env}-${var.app_name}-${var.tr_region}-TG"
    "traderev:automation"  = "${var.automation}"
    "traderev:environment" = "${var.tr_env}"
    "traderev:region"      = "${var.tr_region}"
  }
}

resource "aws_alb_listener" "front_end_http" {
  load_balancer_arn = "${aws_alb.front_end.arn}"
  port              = "${var.http_port}"
  protocol          = "${var.front_end_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.front_end.arn}"
    type             = "forward"
  }

  depends_on = ["aws_alb_target_group.front_end"]
}

resource "aws_alb_listener" "front_end_other" {
  load_balancer_arn = "${aws_alb.front_end.arn}"
  port              = "${var.other_port}"
  protocol          = "${var.front_end_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.front_end.arn}"
    type             = "forward"
  }

  //lifecycle = {
  //  create_before_destroy = true
  //}
  depends_on = ["aws_alb_target_group.front_end"]
}
