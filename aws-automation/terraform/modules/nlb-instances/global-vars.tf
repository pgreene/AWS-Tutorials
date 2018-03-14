// Provider variables
variable "aws_region" {
  description = "aws region, example: us-east-1 (not Company region)"
  default     = ""
}

// Company specific variables
// -----------------------------------------------------
variable "company_env" {
  description = "Company Environments; int, test, stage, auto, uat, demo, prod"
  type        = "string"
  default     = ""
}

variable "company_region" {
  description = "Company Regions, not to be confused with AWS Regions... if your company is international and have deployments in multiple AWS regions"
  type        = "string"
  default     = ""
}

variable "automation" {
  description = "Easily tell which resources were created with terraform"
  type        = "string"
  default     = "terraform"
}

variable "app_name" {
  description = "Gateway, INS, etc"
  type        = "string"
  default     = "BASTION"
}

// -----------------------------------------------------

variable "tags" {
  description = "tag resources"
  type        = "map"
  default     = {}
}

variable "tag" {
  description = "A map of tags to add to all resources"
  type        = "string"
  default     = ""
}

variable "aws_account_id" {
  description = "AWS account ID."
  default     = "12-digit-number-on-AWS-Account"
}

variable "ami_id" {
  type    = "string"
  default = "ami-d6349dac"
}

variable "vpc_id" {
  description = "The VPC resources will go in"
  default     = ""
}
