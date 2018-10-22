Original Reference: https://geekdudes.wordpress.com/2018/06/15/python-script-for-cleaning-up-unused-amazon-ec2-instances/

This terraform plan and module set ups:
* lambda function referenced in above article
* cloudwatch event to trigger the lambda function via CRON scheduler
* iam permissions needed for this to work

<a href="https://github.com/pgreene/AWS-Tutorials/tree/master/automation/terraform/modules/lambda-tagcheck">lambda-tagcheck module</a>

This plan assumes you have an S3 bucket set up for your state files called; state-files
