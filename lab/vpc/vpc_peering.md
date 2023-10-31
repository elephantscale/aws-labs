[<< back to main index](../../README.md)

---

# Creating a Bastion Host (Jump Box)

## Overview:

In this hands-on lab scenario, you’re a cloud network engineer working for a large organization that has multiple VPCs.

Each VPC is dedicated to a business unit (Marketing, Sales).

The Marketing department requires access to all resources in the Sales department, and vice versa.

We will create a VPC peering connection between the Marketing and Sales VPCs, allowing them to act as if they are on the same network. We'll also add the necessary routes to the associated network
route tables.

## Duration

1 hour and 45 minutes

## Dependencies

This Lab requires the following lab to be completed first:

## Steps:

### Step 1: Sign in to AWS Management Console:

Open the AWS Management Console and log in with your credentials.

### Step 2: VPCs

#### Step 2.1: Create Sales VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>-sales-vpc`
* Set the IPv4 CIDR block to: `10.0.0.0/24` (Use the CIDR block that the instructor provides)
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

#### Step 2.2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>-sales-vpc`
* Subnet name: `<YOUR_NAME>-sales-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.0.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 3.1: Create Marketing VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>-marketing-vpc`
* Set the IPv4 CIDR block to: `11.0.0.0/24` (Use the CIDR block that the instructor provides)
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

#### Step 3.2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>-marketing-vpc`
* Subnet name: `<YOUR_NAME>-marketing-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `11.0.0.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 3.1: Create Public VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>-public-vpc`
* Set the IPv4 CIDR block to: `12.0.0.0/24` (Use the CIDR block that the instructor provides)
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

#### Step 3.2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>-public-vpc`
* Subnet name: `<YOUR_NAME>-public-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `12.0.0.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 3.3: Create Routes and Configure Internet Gateway

* Click Create internet gateway.
* Set Name tag as `<YOUR_NAME>-internet-gateway`.
* On the next screen, click Actions > Attach to VPC.
* In the Available VPCs dropdown, select `<YOUR_NAME>-public-vpc`.
* Click Attach internet gateway.
* Click Route Tables in the left-hand menu.
* Select the route table related to `<YOUR_NAME>-vpc` and go to the "Routes" tab. (By the VPC id)
* On the next screen, click Edit routes.
* Click Add route, and set the following values:
    * Destination: `0.0.0.0/0`
    * Target: Internet Gateway, `<YOUR_NAME>-internet-gateway`
* Click Save changes.

#### Step 4.1: Create Central VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>-central-vpc`
* Set the IPv4 CIDR block to: `13.0.0.0/24` (Use the CIDR block that the instructor provides)
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

#### Step 4.2: Create a Central Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>-central-vpc`
* Subnet name: `<YOUR_NAME>-central-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `13.0.0.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

### Step 5: Peer the VPCs

* Go to VPC > Peering Connections.
* Click Create Peering Connection.
* Name: `<YOUR_NAME>-sales-central`
    * `VPC ID`: `<YOUR_NAME>-sales-vpc`
    * `Peer VPC ID`: `<YOUR_NAME>-central-vpc`
* Click Create Peering Connection.
* Go to VPC > Peering Connections.
* Select `<YOUR_NAME>-sales-central` and click Actions > Accept Request.
* Click Yes, Accept.

Do the same for the other VPCs.

### Step 6: EC2 Instances

#### Step 6.1: Create a Public EC2 Instance

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>-public` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>-public-vpc` under VPC.
    - Select `<YOUR_NAME>-public-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>-public-sg` from the dropdown.
- Click “Launch Instances”.

#### Step 6.2: Create a Sales EC2 Instance

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>-sales` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>-sales-vpc` under VPC.
    - Select `<YOUR_NAME>-sales-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>-sales-sg` from the dropdown.
- Click “Launch Instances”.

#### Step 6.3: Create a Marketing EC2 Instance

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>-marketing` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>-marketing-vpc` under VPC.
    - Select `<YOUR_NAME>-marketing-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>-marketing-sg` from the dropdown.
- Click “Launch Instances”.


### Step 7: Route Tables

Instructions for this step will be provided at the second part of the lab.




## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

### Conclusion:

Congratulations! You've successfully created a bastion host (jump box) in AWS.