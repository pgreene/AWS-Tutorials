// route53 outputs
output "route53_public_name" {
    value = "${aws_route53_record.public.name}"
}

//output "route53_vpc_name" {
//    value = "${aws_route53_record.vpc.name}"
//}