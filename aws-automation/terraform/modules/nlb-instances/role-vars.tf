// Role Variables
variable "role_effect" {
  description = "Role Effect"
  default     = ""
}

variable "role_resource" {
  description = "Role Resource"
  default     = ""
}

//variable "iam_instance_profile" {
//  default = "${var.company_env}-${var.app_name}-${var.company_region}-role"
//}
