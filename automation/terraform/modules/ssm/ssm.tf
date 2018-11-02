resource "aws_ssm_patch_baseline" "baseline" {
  name  = "${terraform.workspace}-${var.project}-${var.sub-component}-baseline"
  description = "Patch Baseline for Linux Instances. Created via Terraform from devops github repo."
  operating_system = "${var.operating_system}"
  approved_patches_compliance_level = "${var.approved_patches_compliance_level}"
  //approved_patches = "${var.approved_patches}"
  //rejected_patches = "${var.rejected_patches}"
  //aglobal_filter {
  //a  key = "${var.global_filter_key_1}"
  //a  values = ["${var.global_filter_value_1}"]
  //a}
  //global_filter {
  //  key = "${var.global_filter_key_2}"
  //}
  //global_filter {
  //  key = "${var.global_filter_key_3}"
  //  values = ["${var.global_filter_value_3}"]
  //}
  approval_rule {
    approve_after_days = "${var.approve_after_days}"
    compliance_level = "${var.compliance_level}"
    patch_filter {
      key = "${var.patch_filter_key_1}"
      values = ["${var.patch_filter_value_1}"]
    }
    //patch_filter {
    //  key = "${var.patch_filter_key_2}"
    //  values = ["${var.patch_filter_value_2}"]
    //}
    //patch_filter {
    //  key = "${var.patch_filter_key_3}"
    //  values = ["${var.patch_filter_value_3}"]
    //}
  }
}

resource "aws_ssm_patch_group" "install_patchgroup" {
  count       = "${length(var.install_patch_groups)}"
  baseline_id = "${aws_ssm_patch_baseline.baseline.id}"
  patch_group = "${element(var.install_patch_groups, count.index)}"
}

resource "aws_ssm_maintenance_window" "install_window" {
  name     = "${terraform.workspace}-${var.project}-${var.sub-component}-patch-mtnc-install"
  schedule = "${var.install_maintenance_window_schedule}"
  duration = "${var.maintenance_window_duration}"
  cutoff   = "${var.maintenance_window_cutoff}"
}

resource "aws_ssm_maintenance_window_target" "target_install" {
  window_id     = "${aws_ssm_maintenance_window.install_window.id}"
  resource_type = "${var.resource_type}"

  targets {
    key    = "${var.target_key_1}"
    values = ["${var.scan_patch_groups_1}"]
  }
  targets {
    key    = "${var.target_key_2}"
    values = ["${var.scan_patch_groups_2}"]
  }
}

resource "aws_ssm_maintenance_window_task" "task_install_patches" {
  window_id        = "${aws_ssm_maintenance_window.install_window.id}"
  task_type        = "${var.task_type}"
  task_arn         = "${var.task_arn}"
  priority         = "${var.priority}"
  service_role_arn = "${aws_iam_role.ssm_maintenance_window.arn}"
  max_concurrency  = "${var.max_concurrency}"
  max_errors       = "${var.max_errors}"

  targets {
    key    = "WindowTargetIds"
    values = ["${aws_ssm_maintenance_window_target.target_install.*.id}"]
  }

  task_parameters {
    name   = "${var.task_parameters_name}"
    values = ["${var.task_parameters_values}"]
  }

  logging_info {
    //s3_bucket_name = "${aws_s3_bucket.ssm_patch_log_bucket.id}"
    s3_bucket_name = "${var.s3_bucket_name}"
    s3_region      = "${var.s3_region}"
  }
}
