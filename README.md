AWS-Tutorials
=============

HowTo for AWS

WIKI: https://github.com/pgreene/AWS-Tutorials/wiki

wordpress-vpc-template.cfn : MultiAZ wodpress config within your existing VPC

In this working cloudformation template it uses your existing VPC to build in. Any parameters or property values that begin with "Your" needs to be replaced accordingly. For example, "YourVpcId" needs to be replaced with your actual existing VPC ID in your AWS account. I've improved upon Amazon's existing multiAZ wordpress cloudformation template: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sample-templates-applications-us-east-1.html
