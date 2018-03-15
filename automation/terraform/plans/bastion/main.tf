provider "aws" {
  region  = "us-east-1"
  profile = "prod"
}

// LOCAL VARIABLES
// ------------------------------------------
locals {
  aws_account_id = "374725791127" // devops or prod account id
  project_name         = "BASTION"
  pr_env               = "PROD"
  pr_region            = "US"
  key_name             = "awssshkeypairname"
  vpc_id               = "vpc-85a927e3"             // PROD us-east-1 region
  iam_instance_profile = ""                         // keep empty
}

// ------------------------------------------

module "nlb-instances" {
  source = "../../../modules/nlb-instances/"

  // GLOBAL VARIABLES
  // ------------------------------------------
  pr_env = "${local.pr_env}"

  pr_region = "${local.pr_region}"
  key_name  = "${local.key_name}"
  project_name  = "${local.project_name}"
  vpc_id    = "${local.vpc_id}"

  // ------------------------------------------

  // ROLE VARIABLES
  // ------------------------------------------
  role_effect = "Allow"
  role_resource = "arn:aws:iam::12345678:role/${lower(local.pr_env)}-${lower(local.project_name)}-role"

  // ------------------------------------------

  // SECURITY GROUP VARIABLES
  // ------------------------------------------
  // CIDR Block to allow traffic from
  source_cidr_block = ["0.0.0.0/0"]

  // ------------------------------------------

  // ALB VARIABLES
  // ------------------------------------------
  aws_account_id = "${local.aws_account_id}"
  // alb_name = "${local.alb_name}"
  alb_is_internal = "false"

  // The port the service on the EC2 instances listen on

  // If load balancer connection stickiness is desired,
  // set this to the duration that cookie should be valid. If no stickiness is wanted, leave it blank.
  cookie_duration = 1
  // ALB TARGET GROUP VARIABLES
  backend_protocol = "TCP"
  backend_port     = "22"
  interval         = "10"
  //health_check_path = "/"
  health_check_port     = "80"
  health_check_protocol = "TCP"
  healthy_threshold     = "3"
  unhealthy_threshold   = "3"

  //timeout = "5"
  // ALB Listener Variable
  // certificate_arn = "arn:aws:acm:us-east-1:082894742960:certificate/13cce013-4edc-4b7f-9248-c8d4d4bbf4ac"
  // ------------------------------------------

  // LAUNCH CONFIG VARIABLES
  // ------------------------------------------
  instance_type = "m5.large"
  instance_type_spot   = "m5.large"
  key_name             = "${local.key_name}"
  iam_instance_profile = "${local.iam_instance_profile}"

  // ------------------------------------------

  // ASG VARIABLES
  // ------------------------------------------
  wait_capacity = "5m"
  health_check_grace_period = "1200"
  desired_capacity          = "1"
  min_size                  = "1"
  max_size                  = "20"
  spot_desired_capacity     = "2"
  spot_min_size             = "1"
  spot_max_size             = "20"

  // ------------------------------------------

  // CLOUDWATCH VARIABLES
  // ------------------------------------------
  add_threshold = "90"
  reduce_threshold     = "30"
  add_threshold_net    = "4000000"
  reduce_threshold_net = "1000000"

  // ------------------------------------------

  // AUTOSCALING POLICY VARIABLES
  // ------------------------------------------
  add_scaling_adjustment = "1"
  reduce_scaling_adjustment = "-1"

  // ------------------------------------------

  // ROUTE53 VARIABLES
  // ------------------------------------------
  public_zone_id = "BLAHBLAHBLAH"

  // ------------------------------------------
}
