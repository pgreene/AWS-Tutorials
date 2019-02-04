variable "costcenter" {
  default     = ""
}

variable "owner" {
  default     = ""
}

variable "env" {
  default     = ""
}

variable "project" {
  description = "Project such as Vanguard or Voyanta"
  default     = ""
}

variable "sub-component" {
  description = "Sub Project or Component such as Vanguard Core Services"
  default     = ""
}

variable "runtime" {
  description = "Valid Values: nodejs | nodejs4.3 | nodejs6.10 | nodejs8.10 | java8 | python2.7 | python3.6 | dotnetcore1.0 | dotnetcore2.0 | dotnetcore2.1 | nodejs4.3-edge | go1.x"
  default     = "python3.6"
}

variable "timeout" {
  description = "Function timeout"
  default     = 500
}

variable "subnet_ids" {
  default = []
} 

variable security_group_ids {
  default = []
}