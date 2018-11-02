provider "aws" {
// change profile to your profile for either your-project-name live or test account
  profile = "AWSTestAccount" 
  region     = "us-east-1"
}

// Backend for State File
// S3 Bucket needs to be created called *state-files with versioning enabled
// Default encryption used
// ------------------------------------------

terraform {
  required_version = "~> 0.11.10"
  backend "s3" {
// change profile to your profile for either prod or test account
    profile = "AWSTestAccount"
// change bucket to either test-state-files or prod-state-files if using AWS PROD Account
    bucket  = "test-state-files" 
    key     = "deployment/linux-patching.tfstate"
    region  = "us-east-1"
  }
}

// LOCAL VARIABLES
// ------------------------------------------
locals {
  project        = "your-project-name"

  sub-component = "ecs"
}

// ------------------------------------------

module "ssm" {
  source = "../../modules/ssm/"

// VARIABLES
// ------------------------------------------
  project  = "${local.project}"
  sub-component  = "${local.sub-component}"

// SSM VARIABLES
// ------------------------------------------

operating_system = "AMAZON_LINUX"
approved_patches_compliance_level = "UNSPECIFIED"
approve_after_days = 7
compliance_level = "MEDIUM"
patch_filter_key_1 = "CLASSIFICATION"
patch_filter_value_1 = "Security"
install_patch_groups = ["ECS"]
maintenance_window_duration = "3"
maintenance_window_cutoff = "1"
resource_type = "INSTANCE"

// Target specified by Tags (for scans and installation of patches)
// These would have to exist on EC2 INSTANCE
// In this case, EC2 is being used as ECS Docker Host
// ----------------------------
target_key_1 = "tag:Module"
target_key_2 = "tag:Env"
scan_patch_groups_1 = ["ECS"]
scan_patch_groups_2 = ["${terraform.workspace}"]
// ----------------------------

install_maintenance_window_schedule = "rate(7 days)"
task_type = "RUN_COMMAND"
task_arn = "AWS-RunPatchBaseline"
priority = 1
max_concurrency = "20"
max_errors = "50"
task_parameters_name = "Operation"
task_parameters_values = ["Install"]

// change ssm log bucket to ssm-live-linux-logs if in AWS your-project-name PROD Account
// change ssm log bucket to ssm-linux-logs if in AWS your-project-name TEST Account
s3_bucket_name = "ssm-linux-logs"
s3_region = "us-east-1"
}
