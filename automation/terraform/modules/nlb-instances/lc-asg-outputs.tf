// LC ID output
output "launch_config_id" {
  value = "${aws_launch_configuration.launch_config.id}"
}

output "launch_config_spot_id" {
  value = "${aws_launch_configuration.launch_config_spot.id}"
}

// ASG ID output
output "asg_id" {
  value = "${aws_autoscaling_group.main_asg.id}"
}

output "asg_spot_id" {
  value = "${aws_autoscaling_group.main_asg_spot.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.main_asg.name}"
}

output "asg_spot_name" {
  value = "${aws_autoscaling_group.main_asg_spot.name}"
}
