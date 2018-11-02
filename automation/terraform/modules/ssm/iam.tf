resource "aws_iam_role" "ssm_maintenance_window" {
  name = "${terraform.workspace}-${var.project}-${var.sub-component}-ssm-role"
  assume_role_policy = "${file("${path.module}/files/assume-role-policy.json")}"
}

resource "aws_iam_policy" "ssm_policy" {
  name        = "${terraform.workspace}-${var.project}-${var.sub-component}-policy"
  path        = "/"
  description = "${terraform.workspace}-${var.project}-${var.sub-component} policy"

  policy = "${file("${path.module}/files/role-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "role_attach_ssm_mw" {
  role       = "${aws_iam_role.ssm_maintenance_window.name}"
  policy_arn = "${aws_iam_policy.ssm_policy.arn}"
}