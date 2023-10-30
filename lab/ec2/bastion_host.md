[<< back to main index](../../README.md)

---

# Creating a Bastion Host (Jump Box)

## Overview:

This lab will provide hands-on experience on how to create a bastion host (jump box) in AWS.

A bastion host is a special purpose computer on a network specifically designed and configured to withstand attacks. The computer generally hosts a single application, for example a proxy server, and
all other services are removed or limited to reduce the threat to the computer. It is hardened in this manner primarily due to its location and purpose, which is either on the outside of a firewall or
in a demilitarized zone (DMZ) and usually involves access from untrusted networks or computers.

## Duration

1 hour and 45 minutes

## Steps:

### Step 1: Sign in to AWS Management Console:

Open the AWS Management Console and log in with your credentials.

### Step 2: VPC

#### Step 2.1: Create a VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>_my-bastion-vpc`
* Set the IPv4 CIDR block to: `10.0.0.0/16` (Or the CIDR block that the instructor provides)
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

#### Step 2.2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>_my-bastion-vpc`
* Subnet name: `<YOUR_NAME>_my-bastion-public-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.0.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 2.3: Create a Private Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>_my-bastion-vpc`
* Subnet name: `<YOUR_NAME>_my-bastion-private-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.1.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 2.4: Create Routes and Configure Internet Gateway

**NOTE:** This configuration should only be applied to the public subnet.

* With `<YOUR_NAME>_my-bastion-public-subnet` selected, click Actions > Edit subnet settings.
* Check the box to Enable auto-assign public IPv4 address.
* Click Save.
* Click Internet Gateways in the left-hand menu.

#### Step 2.5: Create Routes and Configure Internet Gateway

* Click Create internet gateway.
* Set Name tag as `<YOUR_NAME>_my-bastion-internet-gateway`.
* On the next screen, click Actions > Attach to VPC.
* In the Available VPCs dropdown, select `<YOUR_NAME>_my-bastion-vpc`.
* Click Attach internet gateway.
* Click Route Tables in the left-hand menu.
* Select the route table related to `<YOUR_NAME>_my-bastion-vpc` and go to the "Routes" tab. (By the VPC id)
* On the next screen, click Edit routes.
* Click Add route, and set the following values:
    * Destination: `0.0.0.0/0`
    * Target: Internet Gateway, `<YOUR_NAME>_my-bastion-internet-gateway`
* Click Save changes.

### Step 3: Create a New Security Group

- Return to the EC2 Dashboard and click on “Instances”.
- Click on the “Create Security Group” button.
- **Name your Security Group**: Provide a descriptive name, e.g., `<YOUR_NAME>_my_bastion_sg`.
- **Description**: Add a brief description, e.g., "Security group for web servers".
- **VPC**: Choose `<YOUR_NAME>_my-bastion-vpc` to associate with this security group.
- **Add Rules**:
    - Under the "Inbound rules" tab, click "Add rule".
        - Select `RDP` from the "Type" dropdown and `0.0.0.0/0` for the "Source" field.

- Click “Create security group”.

### Step 4: Create the public facing EC2 instance

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>_my-public-bastion` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>_my-bastion-vpc` under VPC.
    - Select `<YOUR_NAME>_my-bastion-public-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>_my_bastion_sg` from the dropdown.
- Click “Launch Instances”.

### Step 5: Create the private facing EC2 instance

**NOTE:** This EC2 will not have internet access and will only be accessible through the public facing EC2 (Bastion Host).

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>_my-private-bastion` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>_my-bastion-vpc` under VPC.
    - Select `<YOUR_NAME>_my-bastion-private-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>_my_bastion_sg` from the dropdown.
- Click “Launch Instances”.

### Step 6: Access the EC2 Instance

**NOTE:** At this point you should have two EC2 instances running, one in the public subnet and one in the private subnet.

- Return to the EC2 Dashboard and click on “Instances”.
- Wait until `<YOUR_NAME>_my-public-bastion` state changes to "running" and checks pass.
- Select your instance, and in the “Description” tab below, note the “IPv4 Public IP”.
- Click the “Connect” button.
- In the “Connect To Your Instance” dialog, select “RDP Client”.
- Click on "Get Password" .
- Click Upload private key file and choose the file you downloaded in step 6.
- Click "Decrypt Password".
- Use `Remote Desktop Connection` to connect to the instance using the public IP and the password you just decrypted.
    - You can find `Remote Desktop Connection` by searching for it in the Windows search bar.
    - Enter the public IP in the "Computer" field and click "Connect".
    - Enter the username `administrator` and the password you decrypted in the previous step.
    - Click "Yes" to accept the certificate.
    - You should now be connected to the instance.

### Step 7: Access the private EC2 instance through the public EC2 instance

- Acquire the private IP of the private EC2 instance you just created (`<YOUR_NAME>_my-private-bastion`) based on Step 6.
- Select `<YOUR_NAME>_my-private-bastion` and at the details pane, copy the private IP. (This would be based on the private subnet, for example: `10.0.1.165` )
- Go back to the RDP of the public facing instance, open `Remote Desktop Connection` and enter the private IP of the private EC2 instance.
- You should now be connected to the private EC2 instance through the public EC2 instance.

See if you access the internet from the private EC2 instance?

## Clean Up

Make sure to delete the following resources:

- EC2 instance `<YOUR_NAME>_my_ec2`
- Security group `<YOUR_NAME>_my_sg`
- VPC `<YOUR_NAME>_my-public-bastion`
- VPC `<YOUR_NAME>_my-private-bastion`
- Internet Gateway `<YOUR_NAME>_my-sg-internet-gateway`

### Conclusion:

Congratulations! You've successfully created a bastion host (jump box) in AWS.