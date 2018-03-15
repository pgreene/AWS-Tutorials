// ALB Variables
variable "alb_is_internal" {
  description = "Determines if the ALB is internal. Default: false"
  default     = false
}

variable "front_end_protocol" {
  description = "Protocal HTTP or TCP"
  default     = "TCP"
}

variable "cookie_duration" {
  description = "If load balancer connection stickiness is desired, set this to the duration that cookie should be valid. If no stickiness is wanted, leave it blank. e.g.: 300"
  default     = ""
}

variable "load_balancer_type" {
  description = "Application or Network Load Balancer"
  default     = "network"
}

// Target Group
//variable "health_check_path" {
//  description = "The URL the ELB should use for health checks. e.g. /health"
//  default     = "/"
//}

variable "interval" {
  description = "Health Check Interval in seconds"
  default     = "10"
}

variable "health_check_port" {
  description = "The port the ELB should use for health checks. e.g. 9080"
  default     = ""
}

variable "healthy_threshold" {
  description = "Healthy Threshold for healthy instances behind LB"
  default     = ""
}

variable "unhealthy_threshold" {
  description = "Unhealthy Threshold for healthy instances behind LB"
  default     = ""
}

//variable "timeout" {
//  description = "Timeout on health check"
//  default     = ""
//}

variable "health_check_protocol" {
  description = "The port the ELB should use for health checks. e.g. TCP"
  default     = "TCP"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = 22
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks. Options: HTTP, HTTPS, TCP, SSL (secure tcp)."
  default     = "TCP"
}

variable "other_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = 22
}

// network port variables in securitygroup-vars.tf

