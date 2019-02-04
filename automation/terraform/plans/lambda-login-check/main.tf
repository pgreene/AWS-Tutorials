provider "aws" {
// change to local AWS profile
  profile = "YOUR-AWS-PROFILE" 
  region     = "us-east-1"
}

// Backend for State File
// S3 Bucket needs to be created called *state-files with versioning enabled
// ------------------------------------------

terraform {
  required_version = "~> 0.11.10"
  backend "s3" {
// change to local AWS profile
    profile = "YOUR-AWS-PROFILE"
// change bucket to your terraform state file bucket
    bucket  = "YOUR-TERRAFORM-STATE-FILE-S3-BKT" 
    key     = "deployment/login-check.tfstate"
    region  = "us-east-1"
// If encrypted with KMS Key call terraform;
    kms_key_id = "alias/terraform"
    encrypt = true
  }
}

// LOCAL VARIABLES
// ------------------------------------------
locals {
  project        = "YOUR-PROJECT"

// subcomponent if applicable
  sub-component = "YOUR-SUB-COMPONENT"
}

// ------------------------------------------

module "aws_lambda" {
  source = "../../modules/aws-lambda/"

// VARIABLES
// ------------------------------------------
  project  = "${local.project}"
  sub-component = "${local.sub-component}"
  env = "${terraform.workspace}"

// LAMBDA VARIABLES
// ------------------------------------------
  owner = "YOUR-AWS-IAM-USER"

  runtime = "python2.7"
  timeout = 500
  // to put lambda in VPC;
  subnet_ids = ["subnet-xxxxxxx"]
  security_group_ids = ["sg-xxxxxxx"]

// CLOUDWATCH VARIABLES
// ------------------------------------------
  schedule_expression = "rate(300 minutes)"
}
