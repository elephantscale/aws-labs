[<< back to main index](../../README.md)

---

# Create a Virtual Private Cloud (VPC) with Private and Public Subnets using CloudShell

### Overview

In this lab, you will learn how to create a VPC with one public subnet and one private subnet using AWS CloudShell.

### Depends On

- [Login](../login/login.md)

## Duration

45 minutes

## Regions

Use `us-east-1 (N. Virginia)` unless otherwise specified.

## Steps

### Step 1: Open CloudShell:

From the AWS Management Console top navigation bar, click on the CloudShell icon to open your CloudShell environment.

### Step 2: Create a New VPC:

```bash
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=<YOUR_NAME>_my_vpc}]' --query 'Vpc.VpcId' --output text
```
Note down the VPC ID (e.g., vpc-0123456789abcdef0).

### Step 3: Create a Public Subnet:

```bash
aws ec2 create-subnet --vpc-id VPC_ID --cidr-block 10.0.1.0/24 --availability-zone us-east-1a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=<YOUR_NAME>_public_subnet},{Key=Facing,Value=Public}]' --query 'Subnet.SubnetId' --output text
```
Replace `VPC_ID` with the VPC ID you noted in the previous step. Note down the subnet ID.

Enable auto-assign public IP for this subnet:

```bash
aws ec2 modify-subnet-attribute --subnet-id SUBNET_ID --map-public-ip-on-launch
```
Replace `SUBNET_ID` with the subnet ID you noted.

### Step 4: Create a Private Subnet:

```bash
aws ec2 create-subnet --vpc-id VPC_ID --cidr-block 10.0.1.0/24 --availability-zone us-east-1a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=<YOUR_NAME>_private_subnet},{Key=Facing,
Value=Private}]' --query 'Subnet.SubnetId' --output text
```
Replace `VPC_ID` with the VPC ID from the previous steps.

### Step 5:. Configure Internet Gateway:

Create an Internet Gateway:

```bash
aws ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=<YOUR_NAME>_my_igw}]' --query 'InternetGateway.InternetGatewayId' --output text
```
Note down the Internet Gateway ID.

Attach the Internet Gateway to your VPC:

```bash
aws ec2 attach-internet-gateway --internet-gateway-id IGW_ID --vpc-id VPC_ID
```
Replace `IGW_ID` with the Internet Gateway ID and `VPC_ID` with the VPC ID.

Add a route to the main route table of your VPC:

```bash
aws ec2 create-route --route-table-id ROUTE_TABLE_ID --destination-cidr-block 0.0.0.0/0 --gateway-id IGW_ID
```
Replace `ROUTE_TABLE_ID` with the main route table ID of your VPC (you can find this by describing your VPC), and `IGW_ID` with the Internet Gateway ID.

### Step 6: Clean Up:

```bash
aws ec2 detach-internet-gateway --internet-gateway-id IGW_ID --vpc-id VPC_ID
aws ec2 delete-subnet --subnet-id SUBNETS_ID
aws ec2 delete-vpc --vpc-id VPC_ID
aws ec2 delete-internet-gateway --internet-gateway-id IGW_ID
```
Replace `VPC_ID` with your VPC ID. This will also delete associated resources like subnets and the internet gateway.

## Conclusion

Congratulations! You've used AWS CloudShell to create a VPC with public and private subnets. Remember, while CloudShell provides a command-line interface, always ensure you understand the commands you're executing, especially when making changes to your AWS environment.