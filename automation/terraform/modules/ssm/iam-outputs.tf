output "iam_role_name" {
    value = "${aws_iam_role.ssm_maintenance_window.name}"
}

output "iam_policy_name" {
  value = "${aws_iam_policy.ssm_policy.name}"
}