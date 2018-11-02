output "patch_baseline_name" {
    value = "${aws_ssm_patch_baseline.baseline.name}"
}

output "maintenance_window_name" {
  value = "${aws_ssm_maintenance_window.install_window.name}"
}