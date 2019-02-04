variable "schedule_expression" {
  description = "Event Schedule for Cloutwatch"
  default     = "rate(5 minutes)"
}

variable "is_enabled" {
  description = "true or false"
  default     = "true"
}