'''
PRE-REQUISITE
pip install requests

PURPOSE
To be used in a lambda function

1) check login functionality to web application
2) if login fails, reboot EC2 instance (in this case application server)
'''
import botocore
import boto3
# import boto
# import requests
# If you don't want to import requests and package dependencies for lambda, you can do this;
from botocore.vendored import requests

region = "us-east-1" # AWS REGION
url = "https://TEST-URL/login"
content_type = "application/x-www-form-urlencoded"
cache_control = "no-cache"
user = "TEST-USER"
password = "TEST-USER-PASSWORD"

ec2 = boto3.client('ec2', region_name=region)

# Example of using POST data with requests module
r = requests.post(url, headers={'content-type': content_type, 'Cache-Control': cache_control }, data=[('j_username', user), ('j_password', password)])
print(r.status_code)

instances = ['i-xxxxxxxxxx']

def lambda_handler(event, context):
    if r.status_code == requests.codes.ok:
        print("Login Functionality is Working")
    else:
        print("Login Functionality is not Working. Rebooting instance(s)")
        ec2.reboot_instances(InstanceIds=instances)


