[<< back to main index](../../README.md)

---

# Create a single subnet Virtual Private Cloud (VPC)

### Overview

This activity offers a chance to become acquainted with AWS's fundamental computational and networking features. You'll gain experience working with elements such as VPCs, subnets, routing
configurations, internet gateways, and EC2 instances.

### Depends On

- [Login](../login/login.md)

## Duration

45 minutes

## Regions

- us-east-1 (N. Virginia)

## Note

Please add `<YOUR_NAME>_` as prefix to all the resources you create in this lab.

## Steps

### Step 1: Create a VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
  * Choose: `VPC Only`
  * Assign the Name tag as: `my-vpc`
  * Set the IPv4 CIDR block to: `10.0.0.0/16`
  * Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

### Step 2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `my-vpc`
* Subnet name: `my-public-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.0.0/24`
* Click Create subnet.

### Step 3: Create Routes and Configure Internet Gateway

* With my-public-subnet selected, click Actions > Edit subnet settings.
* Check the box to Enable auto-assign public IPv4 address.
* Click Save.
* Click Internet Gateways in the left-hand menu.
* Click Create internet gateway.
* Set Name tag as `my-internet-gateway`.
* Click Create internet gateway.
* On the next screen, click Actions > Attach to VPC.
* In the Available VPCs dropdown, select `my-vpc`.
* Click Attach internet gateway.
* Click Route Tables in the left-hand menu.
* Click Create route table, and set the following values:
* Name: `publicRT`
* VPC: `my-vpc`
* Click Create route table.
* On the next screen, click Edit routes.
* Click Add route, and set the following values:
* Destination: `0.0.0.0/0`
* Target: Internet Gateway, my-internet-gateway
* Click Save changes.
* Click the Subnet associations tab.
* Click Edit subnet associations.
* Select the box for my-public-subnet.
* Click Save associations.

## Clean Up

Make sure to delete the following resources:

- EC2 instance `<YOUR_NAME>_my_ec2`
- VPC `<YOUR_NAME>_my-sg-vpc`
- Internet Gateway `<YOUR_NAME>_my-sg-internet-gateway`

## Conclusion

Congratulations! You have successfully launched an EC2 instance within a custom VPC, ensuring connectivity and security for Alfredo's Pizza website server. You are now equipped with foundational
knowledge on AWS networking and compute services.