## Plan Usage

<b>IMPORTANT</b>
* terraform workspace for this plan = $ENV
* It is assumed your EC2 Instance(s) have these tags - key : values (for SSM patching target);
    * Env : qa
    * Module : ECS
* S3 bucket for terraform state files is a pre-requisite
* S3 bucket for SSM log files is also created outside this plan, ahead of time

Module Used: <a href="https://github.com/pgreene/AWS-Tutorials/tree/master/automation/terraform/modules/ssm">SSM</a>

### Making Life Easy
to run SSM patch baseline and maintenance window setup in QA:
```bash
cp maintest.txt main.tf
terraform init
terraform workspace list # check existing workspaces (environments)
terraform workspace new qa # create one for QA if it's not already there
terraform workspace select qa # select QA if it is already there
terraform plan
terraform apply
```

Run in PROD:
```bash
cp mainlive.txt main.tf
terraform init
terraform workspace list # check existing workspaces (environments)
terraform workspace new prod # create one for PROD if it's not already there
terraform workspace select prod # select PROD if it is already there
terraform plan
terraform apply
```
