// Provider variables
variable "aws_region" {
  description = "aws region, example: us-east-1 (not Project region)"
  default     = ""
}

// Project specific variables
// -----------------------------------------------------
variable "pr_env" {
  description = "Project Environments; dev, stage, uat, prod"
  type        = "string"
  default     = ""
}

variable "pr_region" {
  description = "Project Regions, not to be confused with AWS Regions; US, CA & UK"
  type        = "string"
  default     = ""
}

variable "automation" {
  description = "Easily tell which resources were created with terraform"
  type        = "string"
  default     = "terraform"
}

variable "project_name" {
  description = "bastion setup"
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
  default     = "123456789123"
}

variable "ami_id" {
  type    = "string"
  default = "ami-12345678"
}

variable "vpc_id" {
  description = "The VPC resources will go in"
  default     = ""
}
