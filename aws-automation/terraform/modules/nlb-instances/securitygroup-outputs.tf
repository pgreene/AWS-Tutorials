// security_group outputs
output "sg_id" {
  value = "${aws_security_group.main.id}"
}
