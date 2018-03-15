// Security Group Variables
variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "source_cidr_office" {
  description = "The source CIDR block to allow traffic from"
  type        = "list"

  // Office IPs
  default = ["55.55.55.55/31", "55.55.55.55/27"]
}

variable "ssh_port" {
  description = "ssh port"
  default     = 22
}

variable "allowed_security_groups" {
  default = []
}

// http and other port also used in alb-vars.tf
variable "http_port" {
  description = "https port"
  default     = 80
}

variable "https_port" {
  description = "https port"
  default     = 443
}

variable "custom_from_port" {
  description = "custom from port"
  default     = 3307
}

variable "custom_to_port" {
  description = "custom to port"
  default     = 3310
}
