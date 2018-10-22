resource "aws_iam_role" "iam_for_lambda" {
  name = "${terraform.workspace}-${var.project}${var.sub-component}-iamrole"
  assume_role_policy = "${file("${path.module}/files/assume-role-policy.json")}"
}
  
resource "aws_iam_policy" "lambda_policy" {
  name        = "${terraform.workspace}-${var.project}${var.sub-component}-policy"
  path        = "/"
  description = "${terraform.workspace}-${var.project}${var.sub-component} policy"

  policy = "${file("${path.module}/files/role-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

