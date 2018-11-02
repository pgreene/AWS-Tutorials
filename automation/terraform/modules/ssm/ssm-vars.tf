variable "project" {
  description = "Project Name"
  default     = "your-project-name"
}

variable "sub-component" {
  description = "Sub Project or Component Name"
  default     = ""
}

variable "operating_system" {
  description = "(Optional) Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON_LINUX, AMAZON_LINUX_2, SUSE, UBUNTU, CENTOS, and REDHAT_ENTERPRISE_LINUX. The Default value is WINDOWS."
  default     = "AMAZON_LINUX"
}

variable "approved_patches_compliance_level" {
  description = "(Optional) Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
  default     = "UNSPECIFIED"
}

variable "approve_after_days" {
  description = "The number of days after the release date of each patch matched by the rule the patch is marked as approved in the patch baseline. Valid Range: 0 to 100."
  default     = 7
}

variable "compliance_level" {
  description = "Defines the compliance level for patches approved by this rule. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
  default     = "MEDIUM"
}

variable "patch_filter_key_1" {
  description = "(Required) The patch filter group that defines the criteria for the rule. Up to 4 patch filters can be specified per approval rule using Key/Value pairs. Valid Keys are PRODUCT | CLASSIFICATION | MSRC_SEVERITY | PATCH_ID."
  default = "CLASSIFICATION"
}

variable "patch_filter_value_1" {
  description = "valid values for linux Classification are: Security, Bugfix, Enhancement, Recommended, Newpackage"
  default = "Security"
}

variable "install_patch_groups" {
  description = "The list of install patching groups, one target will be created per entry in this list"
  type    = "list"
  default = ["ECS"]
}

variable "maintenance_window_duration" {
  description = "The duration of the maintenence windows (hours)"
  default = "3"
}

variable "maintenance_window_cutoff" {
  description = "The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution"
  type = "string"
  default = "1"
}

variable "resource_type" {
  default = "INSTANCE"
}

variable "target_key_1" {
default = "tag:Module"
}

variable "scan_patch_groups_1" {
  default = ["ECS"]
}

variable "target_key_2" {
default = ""
}

variable "scan_patch_groups_2" {
  default = ["tempdev"]
}
  
variable "install_maintenance_window_schedule" {
  description = "The schedule of the install Maintenance Window in the form of a cron or rate expression"
  type = "string"
  default = "cron(0 0 21 ? * WED *)"
}

variable "task_type" {
  default = "RUN_COMMAND"
}

variable "task_arn" {
  default = "AWS-ApplyPatchBaseline"
}

variable "priority" {
  default = 1
}

variable "max_concurrency" {
  description = "The maximum amount of concurrent instances of a task that will be executed in parallel"
  type    = "string"
  default = "20"
}

variable "max_errors" {
  description = "The maximum amount of errors that instances of a task will tollerate before being de-scheduled"
  type    = "string"
  default = "50"
}

variable "task_parameters_name" {
  default = "Operation"
}

variable "task_parameters_values" {
  default = ["Install"]
}

variable "s3_bucket_name" {
  default = "ssm-linux-logs"
}

variable "s3_region" {
  default = "us-east-1"
}
