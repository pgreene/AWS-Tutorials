// role outputs
output "role_name" {
  value = "${aws_iam_role.a_role.*.name}"
}
