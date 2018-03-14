// Security Group Variables
variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "source_cidr_office" {
  description = "The source CIDR block to allow traffic from"
  type        = "list"
  default     = ["216.123.13.138/31", "207.35.164.0/27", "174.118.219.104/32"]
}

variable "ssh_port" {
  description = "ssh port"
  default     = 22
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
