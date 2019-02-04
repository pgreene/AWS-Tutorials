## Usage
Uses local AWS Config for provider - will need to update profile name to properly run it in main.tf


### Run lambda setup in UAT environment
```bash
terraform init
terraform workspace list
terraform workspace new uat
# terraform workspace select uat
terraform plan
terraform apply
```


*These configs will change based on your own local AWS config*

```bash
provider "aws" {
  profile = "YOUR-AWS-PROFILE"
  region     = "us-east-1"
}
```

*Config to use S3 bucket for state files*

```bash
terraform {
  required_version = "~> 0.11.10"
  backend "s3" {
    profile = "YOUR-AWS-PROFILE"
// change bucket to your terraform state file bucket
    bucket  = "YOUR-TERRAFORM-STATE-FILE-BKT" 
    key     = "deployment/login-check.tfstate"
    region  = "us-east-1"
    kms_key_id = "alias/terraform"
    encrypt = true
  }
}

# Ensure latest python script with updates is zipped up for lambda
# Example:  
zip -r uat-YOUR-PROJECT-YOUR-SUB-COMPONENT-logincheck.zip uat-YOUR-PROJECT-YOUR-SUB-COMPONENT-logincheck.py
```


