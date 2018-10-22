provider "aws" {
  profile = "default"
  region     = "us-east-1"
}

// Backend for State File
// KMS Key needs to be created in IAM
// S3 Bucket needs to be created called state-files with versioning enabled
// ------------------------------------------

terraform {
  required_version = "~> 0.11.8"
  backend "s3" {
    bucket  = "state-files"
    key     = "deployment/lambda-tagcheck.tfstate"
    region  = "us-east-1"
    kms_key_id = "alias/terraform"
    encrypt = true
  }
}

// LOCAL VARIABLES
// ------------------------------------------
locals {
  project        = "Project-Name"

// subcomponent would be a subcomponent of Project-Name if applicable
  sub-component = ""
}

// ------------------------------------------

module "lambda_tagcheck" {
  source = "../../modules/lambda-tagcheck/"

// VARIABLES
// ------------------------------------------
  project  = "${local.project}"

// LAMBDA VARIABLES
// ------------------------------------------
  runtime = "python3.6"
  timeout = 500

// CLOUDWATCH VARIABLES
// ------------------------------------------
  schedule_expression = "rate(10 minutes)"

}