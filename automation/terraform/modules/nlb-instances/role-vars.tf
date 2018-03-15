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
//  default = "${var.tr_env}-${var.project_name}-${var.tr_region}-role"
//}
