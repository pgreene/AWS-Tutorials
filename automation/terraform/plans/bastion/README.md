## BASTION HOST HA SET UP

* In this plan configuration ensure you update the following variables;
    * key_name
    * vpc_id
    * role_resource
    * instance_type
    * instance_type_spot
    * public_zone_id // Your route53 domain name


## Set Up
* Packer creates the initial AMI for terraform to use
* Terraform picks up the instance based on tag name (see data.tf in nlb-instances module)
* 2 bastion host instances are created in a target group behind a network load balancer
* Cloudwatch Monitoring is set up on CPU and Network Throughput
* Route53 subdomain name is generated
