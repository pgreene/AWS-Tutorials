// Get IP Ranges or CIDR from VPC
data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

// user_data.sh template file
data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh")}"
}

// Get all subnets for the VPC where the tag 'type=private'
data "aws_subnet_ids" "private" {
  vpc_id = "${var.vpc_id}"

  tags {
    type = "private"
  }
}

// Get all subnets for the VPC where the tag 'type=public'
data "aws_subnet_ids" "public" {
  vpc_id = "${var.vpc_id}"

  tags {
    type = "public"
  }
}

// Latest AMI tagged with... example "Name=bastion_ami"
data "aws_ami" "recent_ami" {
  most_recent = true

  filter {
    name   = "tag:Name"
    values = ["${lower(var.project_name)}_latest"]
  }
}

data "aws_vpc" "app_vpc" {
  id = "${var.vpc_id}"
}

// Current Terarform Provider region
data "aws_region" "current" {
  current = true
}
