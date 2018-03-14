// Role
resource "aws_iam_role" "a_role" {
  name               = "${var.tr_env}-${var.app_name}-${var.tr_region}-role"
  description        = "Managed by Terraform"
  assume_role_policy = "${file("${path.module}/files/assume-role-policy.json")}"

  //count = "${var.iam_instance_profile == "" ?  1 : 0}"
}

resource "aws_iam_role_policy" "a_policy" {
  role   = "${aws_iam_role.a_role.id}"
  policy = "${file("${path.module}/files/role-policy.json")}"

  //count = "${var.iam_instance_profile == "" ?  1 : 0}"
}

resource "aws_iam_instance_profile" "iam_profile" {
  name = "${var.tr_env}-${var.app_name}-${var.tr_region}-IamProfile"
  role = "${aws_iam_role.a_role.name}"

  //count = "${${var.tr_env}-${var.app_name}-${var.tr_region}-IamProfile == "" ?  1 : 0}"
}
