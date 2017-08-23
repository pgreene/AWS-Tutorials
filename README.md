AWS-Tutorials
=============

HowTo for AWS

WIKI: https://github.com/pgreene/AWS-Tutorials/wiki

## Helpful AWS Files and Templates
<ul>
<li><b>wordpress-vpc-template.cfn</b> : MultiAZ wodpress config within your existing VPC

In this working cloudformation template it uses your existing VPC to build in. Any parameters or property values that begin with "Your" needs to be replaced accordingly. For example, "YourVpcId" needs to be replaced with your actual existing VPC ID in your AWS account. I've improved upon Amazon's existing multiAZ wordpress cloudformation template: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sample-templates-applications-us-east-1.html

If you prefer YAML over JSON you can [convert JSON to YAML](https://www.json2yaml.com/)
</li>
<li><b>generate-listaminames</b> : Generate a script that lists all AMI Names used in all your AWS launch configurations</li>
<li><b>generate-listattachedrolepolicies</b> : Generate a script that lists all Attached Policies on your existing AWS IAM Roles</li>
</ul>
