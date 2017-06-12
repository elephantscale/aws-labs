# how to run ?
#  $  AWS_PROFILE=es-training-sujee  python list-resources.py

# credentials are picked up from ~/.aws/credentials
#     [es-training]  #sujee
#     aws_access_key_id = XXXX
#     aws_secret_access_key = YYYY
#     region=us-west-2

import boto3
from pprint import pprint

## config
profile='es-training'

### end config

# get a 'es-training' session
session = boto3.Session(profile_name='es-training')

#client = boto3.client('iam')
client = session.client('iam')
#iam_users = client.list_users()
#pprint(iam_users)

ec2 = session.resource('ec2')
for inst in ec2.instances.all():
    pprint(inst)
