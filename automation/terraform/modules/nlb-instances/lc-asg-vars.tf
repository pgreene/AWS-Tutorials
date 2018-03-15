// ASG Variables
variable "wait_capacity" {
  description = "Amount of time to wait while ASG is being created"
  type        = "string"
  default     = ""
}

variable "min_size" {
  type    = "string"
  default = ""
}

variable "max_size" {
  type    = "string"
  default = ""
}

variable "desired_capacity" {
  type    = "string"
  default = "1"
}

variable "spot_min_size" {
  type    = "string"
  default = "0"
}

variable "spot_max_size" {
  type    = "string"
  default = "20"
}

variable "spot_desired_capacity" {
  type    = "string"
  default = ""
}

variable "health_check_type" {
  description = "Health check used by the ASG"
  type        = "string"
  default     = "ELB"
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 300
}

variable "adjustment_type" {
  type    = "string"
  default = "ChangeInCapacity"
}

variable "adjustment_type_spot" {
  type    = "string"
  default = "ChangeInCapacity"
}

//variable "metric_aggregation_type" {
//  default = "Average"
//}

variable "cooldown" {
  default = 300
}

variable "cooldown_spot" {
  default = 300
}

variable "add_scaling_adjustment" {
  default = 1
}

variable "reduce_scaling_adjustment" {
  default = -1
}

// Launch Config Variables

variable "security_group_ids" {
  default = []
}

variable "enable_monitoring" {
  default = ""
}

variable "associate_public_ip_address" {
  default = ""
}

variable "instance_type" {
  type    = "string"
  default = "m5.large"
}

variable "instance_type_spot" {
  type    = "string"
  default = "m5.large"
}

variable "key_name" {
  description = "Key Pair Name"
  type        = "string"
  default     = ""
}

variable "user_data" {
  description = "User data script used by launch config"
  type        = "string"
  default     = ""
}

variable "iam_instance_profile" {
  type    = "string"
  default = ""
}

// Cloudwatch
variable "evaluation_periods" {
  default = "2"
}

variable "evaluation_periods_spot" {
  default = "2"
}

variable "cpu_metric_name" {
  default = "CPUUtilization"
}

variable "net_metric_name" {
  default = "NetworkIn"
}

variable "namespace" {
  default = "AWS/EC2"
}

variable "namespace_spot" {
  default = "AWS/EC2Spot"
}

variable "period" {
  default = "120"
}

variable "period_spot" {
  default = "120"
}

variable "statistic" {
  default = "Average"
}

variable "statistic_spot" {
  default = "Average"
}

variable "statistic_net" {
  default = "Sum"
}

variable "statistic_net_spot" {
  default = "Sum"
}

variable "add_threshold" {
  default = "90"
}

variable "reduce_threshold" {
  default = "30"
}

variable "add_threshold_net" {
  default = "2000000"
}

variable "reduce_threshold_net" {
  default = "1000000"
}
