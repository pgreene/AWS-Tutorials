variable "allowed_cidr" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ]

  description = "A list of CIDR Networks to allow ssh access to."
}

variable "allowed_ipv6_cidr" {
  type = "list"

  default = [
    "::/0",
  ]

  description = "A list of IPv6 CIDR Networks to allow ssh access to."
}

variable "allowed_security_groups" {
  type        = "list"
  default     = []
  description = "A list of Security Group ID's to allow access to."
}

variable "name" {
  default = "bastion"
}

variable extra_tags {
  type        = "list"
  default     = []
  description = "A list of tags to associate to the bastion instance."
}

variable "ami" {
  default = ""
}

variable "instance_type" {
  default = "m5.xlarge"
}

variable "user_data_file" {
  default = "user_data.sh"
}

variable "enable_monitoring" {
  default = true
}

variable "ssh_user" {
  default = "ubuntu"
}

variable "additional_user_data_script" {
  default = ""
}

variable "region" {
  default = "us-east-1"
}

variable "security_group_ids" {
  description = "Comma seperated list of security groups to apply to the bastion."
  default     = ""
}

variable "subnet_ids" {
  default     = []
  description = "A list of subnet ids"
}

variable "eip" {
  default = ""
}

variable "associate_public_ip_address" {
  default = true
}

variable "key_name" {
  default = ""
}
