[<< back to main index](../../README.md)

---

# Creating a VPC Transit Gateway

## Overview:

In this hands-on lab scenario, you’re a cloud network engineer working for a large organization that has multiple VPCs.

You have been tasked with creating a VPC Transit Gateway to connect the VPCs together and allow them to communicate with each other.

## Duration

2 hours

## Dependencies

This Lab requires:

- VPC creation
- EC2 creation
- Security Group creation
- Route Table creation
- Internet Gateway creation

## Notes

- This lab is part of a series of labs that will guide you through the process of creating a VPC Transit Gateway.
- This lab is divided into two parts. In the first part, you will create the VPCs and the EC2 instances. In the second part, you will create the Transit Gateway and connect the VPCs to it.

## Steps:

## Part 1

### Step 1: Sign in to AWS Management Console:

Open the AWS Management Console and log in with your credentials.

### Step 2: VPCs

#### Step 2.1: A VPC

Choose one region and create the following VPC:

Create the following VPC:

- Name: `<YOUR_NAME>-A`
- IPv4 CIDR block: `10.0.0.0/16`
- Subnets:
    - Public:
        * IPv4 CIDR block: `10.0.0.0/24`
    - Private:
        * IPv4 CIDR block: `10.0.1.0/24`
        * Dedicated `Route Table`

#### Step 2.2: B VPC

Create the following VPC in the same region as the previous VPC:

- Name: `<YOUR_NAME>-B`
- IPv4 CIDR block: `10.1.0.0/16`
- Subnets:
    - Public:
        * IPv4 CIDR block: `10.1.0.0/24`
    - Private:
        * IPv4 CIDR block: `10.1.1.0/24`
        * Dedicated `Route Table`

#### Step 2.2: C VPC

Create the following VPC in the same region as the previous VPC:

- Name: `<YOUR_NAME>-B`
- IPv4 CIDR block: `10.2.0.0/16`
- Subnets:
    - Public:
        * IPv4 CIDR block: `10.2.0.0/24`
    - Private:
        * IPv4 CIDR block: `10.2.1.0/24`
        * Dedicated `Route Table`

### Step 3: Instances

Create the following instances in the public subnets of each VPC:

- VPC A:
    - `Windows` on public subnet
    - `Ubuntu` on private subnet
    - `Windows` on private subnet
- VPC B:
    - `Windows` on public subnet
    - `Ubuntu` on private subnet
    - `Windows` on private subnet
- VPC C:
    - `Windows` on public subnet
    - `Ubuntu` on private subnet
    - `Windows` on private subnet

Do not forget to create NAT Gateways for the private subnets.

### Step 4: Test Instances

Connect to the instances and test connectivity between them.

- You should be able to connect to the public instances from your computer.
- You should be able to connect to the private instances from the public instances.
- You should not be able to connect to the private instances from your computer.
- You should not be able to connect to the private instances from the public instances in other VPCs.

### Step 5: Transit Gateway

#### Step 5.1: Create Transit Gateway

- Go to `Transit Gateway` and create a new Transit Gateway.
- Name: `<YOUR_NAME>-<REGION>-Transit-Gateway`
- Click on `Create Transit Gateway`.

#### Step 5.2: Create Transit Gateway Attachments

- Go to `Transit Gateway Attachments` and create a new Transit Gateway Attachment.
- Name: `<YOUR_NAME>-<REGION>-TG-Private-A`
- Transit Gateway ID: `<YOUR_NAME>-<REGION>-Transit-Gateway`
- Attachment Type: `VPC`
- VPC ID: `<YOUR_NAME>-A`
- Subnet IDs: `<YOUR_NAME>-Private-A` public subnet

Repeat the process for VPC B and VPC C private subnets.

### Step 6: Route Tables for Transit Gateway

- Go to `Route Tables` and access the route table of the private subnets of VPC A to VPC B.
- Add a new route:
    - Destination: `10.1.0.0/16`
    - Target: `Transit Gateway`
    - Transit Gateway ID: `<YOUR_NAME>-<REGION>-Transit-Gateway`
    - Click on `Create Route`.
- Repeat the process for VPC B to VPC A, VPC A to VPC C, and VPC C to VPC A.

## End of Part 1

## Part 2

#### Step 7: D VPC

Create the following VPC in a different region:

- Name: `<YOUR_NAME>-D`
- IPv4 CIDR block: `10.3.0.0/16`
- Subnets:
    - Public:
        * IPv4 CIDR block: `10.3.0.0/24`
    - Private:
        * IPv4 CIDR block: `10.3.1.0/24`
        * Dedicated `Route Table`

### Step 8: Instances

Create the following instances in VPC D:

- VPC D:
    - `Windows` on public subnet
    - `Ubuntu` on private subnet
    - `Windows` on private subnet

Do not forget to create NAT Gateways for the private subnets.

### Step 8: Transit Gateway

#### Step 8.1: Create Transit Gateway

- Go to `Transit Gateway` and create a new Transit Gateway.
- Name: `<YOUR_NAME>-<REGION>-Transit-Gateway`
- Click on `Create Transit Gateway`.

#### Step 8.2: Create Transit Gateway Attachments

- Go to `Transit Gateway Attachments` and create a new Transit Gateway Attachment.
- Name: `<YOUR_NAME>-<REGION>-TG-Private-D`
- Transit Gateway ID: `<YOUR_NAME>-<REGION>-Transit-Gateway`
- Attachment Type: `VPC`
- VPC ID: `<YOUR_NAME>-D`
- Subnet IDs: `<YOUR_NAME>-Private-D` public subnet

#### Step 8.3: Create Cross Region Transit Gateway Attachments

- Go to your main region.
- Go to `Transit Gateway Attachments` and create a new Transit Gateway Attachment.
- Name: `<YOUR_NAME>-<SOURCE_REGION>-<DEST_REGION>-TG-Private-D`
- Transit Gateway ID: `<YOUR_NAME>-<REGION>-Transit-Gateway`
- Type: `Peering`
- Account: My Account
- Region: `<DEST_REGION>`
- Transit Gateway ID: Get from the Transit Gateway in the destination region
- Click on `Create Transit Gateway Attachment`.
- Status: `Initiating Request`

Wait for a few minutes for the attachment to be created.

Status should become:  `Pending Acceptance`

#### Step 8.4: Accept Cross Region Transit Gateway Attachments

- Go to the destination region.
- Go to `Transit Gateway Attachments` and accept the attachment.
- Select the attachment and click on `Accept Attachment`.

Wait for a few minutes for the attachment to be accepted.

Status should become:  `Available`

### Step 9: Route Tables for Transit Gateway

- Go to `Route Tables` and access the route table of the private subnets of VPC A to VPC D.

- Add a new route:
    - Destination: `10.3.0.0/16`
    - Target: `Transit Gateway`
    - Transit Gateway ID: `<YOUR_NAME>-<REGION>-Transit-Gateway`
    - Click on `Create Route`.
- Repeat the process for VPC D to VPC A.

On Dest Region:
- Go to `Transit Gateway Route Tables` and access the route table of the Transit Gateway.
- Select the route table and click on `Create Static Route`.
  - Destination: `10.0.0.0/16`
  - Choose Attachment: `<YOUR_NAME>-<REGION>-TG-Private-D`

On Source Region:  
- Go to `Transit Gateway Route Tables` and access the route table of the Transit Gateway.
- Select the route table and click on `Create Static Route`.
  - Destination: `10.3.0.0/16`
  - Choose Attachment: `<YOUR_NAME>-<REGION>-TG-Private-D`

## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

### Conclusion:

Congratulations! You've successfully created a VPC Transit Gateway.

[<< back to main index](../../README.md)