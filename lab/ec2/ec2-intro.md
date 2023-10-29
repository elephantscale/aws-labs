# AWS EC2 (Elastic Compute Cloud) Lab Guide

The purpose of this lab is to create, configure, and access an EC2 instance. This will give you hands-on experience with Amazon's virtual server offering.

## Prerequisites:

- An AWS account.
- Basic knowledge of AWS services.

## Duration

30 minutes

### Depends On

- [Create VPC](../vpc/vpc-intro.md)

## Steps:

### 1. Sign in to AWS Management Console

Navigate to the AWS Management Console and sign in.

### 2. Access the EC2 Dashboard

On the AWS Management Console, find and click on the “EC2” service under “Compute” to open the EC2 Dashboard.

### 3. Launch a New EC2 Instance

1. Click the “Launch Instance” button.
2. **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
3. **Choose an Instance Type**: Select "t2.xlarge".
4. **Create Key**: Select "Create a new key pair" and enter a name for the key pair (e.g., "myEC2key"). Click "Download Key Pair" and store it securely. Click "Launch Instances".
5. **Configure Instance Details**: Keep the default settings for now and click "Next".
6. **Network**: Select the VPC you created in the previous lab.
7. **Security Group**: Select "Select Create a new security group" and enter a name for the security group (e.g., "rdp"). Make sure the "Type" is set to "RDP".
8. Click “Launch Instances”.

### 4. Access the EC2 Instance

1. Return to the EC2 Dashboard and click on “Instances”.
2. Wait until your instance state changes to "running" and checks pass.
3. Select your instance, and in the “Description” tab below, note the “IPv4 Public IP”.
4. Click the “Connect” button.
5. In the “Connect To Your Instance” dialog, select “RDP Client”.
6. Click on "Get Password" and select the key pair you created in step 3. Click "Decrypt Password".

### 5. Explore

RDP into the instance and explore the Windows Server environment.

## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

### Conclusion

In this lab, you learned how to create, configure, access, and terminate an EC2 instance on AWS. This is a foundational skill for anyone working with AWS. Remember always to terminate resources after
usage to avoid unwanted costs.