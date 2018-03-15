// Security Group
resource "aws_security_group" "main" {
  name        = "${var.pr_env}-${var.project_name}-${var.pr_region}-SG"
  description = "${var.pr_env}-${var.project_name}-${var.pr_region}-SG"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name                   = "${var.pr_env}-${var.project_name}-${var.pr_region}-SG"
    "automation"  = "${var.automation}"
    "environment" = "${var.pr_env}"
    "region"      = "${var.pr_region}"
  }
}

resource "aws_security_group_rule" "ssh_ingress" {
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = ["${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"]

  //ipv6_cidr_blocks  = "${var.allowed_ipv6_cidr}"
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "ssh_sg_ingress" {
  count                    = "${length(var.allowed_security_groups)}"
  type                     = "ingress"
  from_port                = "${var.ssh_port}"
  to_port                  = "${var.ssh_port}"
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_security_groups, count.index)}"
  security_group_id        = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "ssh_office_ingress" {
  type        = "ingress"
  from_port   = "${var.ssh_port}"
  to_port     = "${var.ssh_port}"
  protocol    = "tcp"
  cidr_blocks = "${var.source_cidr_office}"
  description = "Office IPs"

  //ipv6_cidr_blocks  = "${var.allowed_ipv6_cidr}"
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "custom_office_ingress" {
  type        = "ingress"
  from_port   = "${var.custom_from_port}"
  to_port     = "${var.custom_to_port}"
  protocol    = "tcp"
  cidr_blocks = "${var.source_cidr_office}"

  //ipv6_cidr_blocks  = "${var.allowed_ipv6_cidr}"
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "main_all_egress" {
  type      = "egress"
  from_port = "0"
  to_port   = "65535"
  protocol  = "all"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  //ipv6_cidr_blocks = [
  //  "::/0",
  //]

  security_group_id = "${aws_security_group.main.id}"
}

// Allow TCP:80
resource "aws_security_group_rule" "ingress_tcp_self" {
  security_group_id = "${aws_security_group.main.id}"
  from_port         = "${var.http_port}"
  to_port           = "${var.http_port}"
  protocol          = "tcp"
  cidr_blocks       = "${var.source_cidr_block}"
  type              = "ingress"
}

// Allow TCP:443
resource "aws_security_group_rule" "ingress_tcp_443_self" {
  security_group_id = "${aws_security_group.main.id}"
  from_port         = "${var.https_port}"
  to_port           = "${var.https_port}"
  protocol          = "tcp"
  cidr_blocks       = "${var.source_cidr_block}"
  type              = "ingress"
}
