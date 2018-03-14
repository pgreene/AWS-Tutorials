provider "aws" {
  region  = "us-east-1"
  profile = "prod"
}

locals {
  app_name   = "BASTION"
  company_env     = "PROD"
  company_region  = "CA"
  key_name   = "aws-prod-keyname"
  automation = "terraform"
}

module "bastion" {
  source        = "../modules/nlb-instances/"
  instance_type = "m5.large"

  region = "us-east-1"
  vpc_id = "existing-vpc-id"

  app_name  = "${local.app_name}"
  company_env    = "${local.company_env}"
  company_region = "${local.company_region}"
  key_name  = "${local.key_name}"

  // ------------------------------------------
  // HEALTH CHECK
  // ------------------------------------------
  interval = "10"
  health_check_port     = "22"
  healthy_threshold     = "3"
  unhealthy_threshold   = "3"
  health_check_protocol = "TCP"
  // ------------------------------------------
  // ROUTE53 VARIABLES
  // ------------------------------------------
  zone_id = "EXISTINGZONEID"
  public_zone_id = "EXISTINGZONEID"
}
