[<< back to main index](../../README.md)

---

# Create a Virtual Private Cloud (VPC) with NAT for Private Subnets

### Overview

In this lab, you will learn how to create a VPC with one public subnet and one private subnet in AWS and provide internet access to the private subnet using a NAT Gateway.

This setup allows you to have resources that are directly accessible from the internet (in the public subnet) and resources that aren't (in the private subnet).

## Duration

1 hour and 45 minutes

## Regions

- Depending on the lab, you may be asked to use a specific region. If not, please use `us-east-1 (N. Virginia)`.

## Steps

#### Step 2.1: Create a VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>-vpc`
* Set the IPv4 CIDR block to: `10.0.0.0/16` (Or the CIDR block that the instructor provides)
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

#### Step 2.2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>-vpc`
* Subnet name: `<YOUR_NAME>-public-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.0.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 2.3: Create a Private Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>-vpc`
* Subnet name: `<YOUR_NAME>-private-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.1.0/24` (Or the CIDR block that the instructor provides)
* Click Create subnet.

#### Step 2.4: Create Routes and Configure Internet Gateway

**NOTE:** This configuration should only be applied to the public subnet.

* With `<YOUR_NAME>-public-subnet` selected, click Actions > Edit subnet settings.
* Check the box to Enable auto-assign public IPv4 address.
* Click Save.
* Click Internet Gateways in the left-hand menu.

#### Step 2.5: Create Routes and Configure Internet Gateway

* Click Create internet gateway.
* Set Name tag as `<YOUR_NAME>-internet-gateway`.
* On the next screen, click Actions > Attach to VPC.
* In the Available VPCs dropdown, select `<YOUR_NAME>-vpc`.
* Click Attach internet gateway.
* Click Route Tables in the left-hand menu.
* Select the route table related to `<YOUR_NAME>-vpc` and go to the "Routes" tab. (By the VPC id)
* On the next screen, click Edit routes.
* Click Add route, and set the following values:
    * Destination: `0.0.0.0/0`
    * Target: Internet Gateway, `<YOUR_NAME>-internet-gateway`
* Click Save changes.

### Step 3: Create a New Security Group

- Return to the EC2 Dashboard and click on “Instances”.
- Click on the “Create Security Group” button.
- **Name your Security Group**: Provide a descriptive name, e.g., `<YOUR_NAME>-sg`.
- **Description**: Add a brief description, e.g., "Security group for web servers".
- **VPC**: Choose `<YOUR_NAME>-vpc` to associate with this security group.
- **Add Rules**:
    - Under the "Inbound rules" tab, click "Add rule".
        - Select `RDP` from the "Type" dropdown and `0.0.0.0/0` for the "Source" field.

- Click “Create security group”.

### Step 4: Create the public facing EC2 instance

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>-public` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>-vpc` under VPC.
    - Select `<YOUR_NAME>-public-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>-sg` from the dropdown.
- Click “Launch Instances”.

### Step 5: Create the private facing EC2 instance

**NOTE:** This EC2 will not have internet access and will only be accessible through the public facing EC2 (Bastion Host).

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>-private` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>-vpc` under VPC.
    - Select `<YOUR_NAME>private-subnet` under Subnet.
    - Choose `Select existing security group` and select `<YOUR_NAME>-sg` from the dropdown.
- Click “Launch Instances”.

### Step 6: Access the EC2 Instance

**NOTE:** At this point you should have two EC2 instances running, one in the public subnet and one in the private subnet.

- Return to the EC2 Dashboard and click on “Instances”.
- Wait until `<YOUR_NAME>-public` state changes to "running" and checks pass.
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

- Acquire the private IP of the private EC2 instance you just created (`<YOUR_NAME>-private`) based on Step 6.
- Select `<YOUR_NAME>-private` and at the details pane, copy the private IP. (This would be based on the private subnet, for example: `10.0.1.165` )
- Go back to the RDP of the public facing instance, open `Remote Desktop Connection` and enter the private IP of the private EC2 instance.
- You should now be connected to the private EC2 instance through the public EC2 instance.

See if you access the internet from the private EC2 instance?

### Step 8: Elastic IP

- Go to VPC > Elastic IPs.
- Click Allocate Elastic IP address.
- Select Amazon's pool of IPv4 addresses and click Allocate.

### Step 9: Create a NAT Gateway

- Go to VPC > NAT Gateways.
- Click Create NAT Gateway.
- Set the following values:
    - Name tag: `<YOUR_NAME>-nat-gateway`
    - Subnet: `<YOUR_NAME>-public` (Yes, the public subnet)
    - Elastic IP Allocation ID: Select the Elastic IP you created in the previous step.

- Click Create NAT Gateway.

### Step 10: Create a Route Table

- Go to VPC > Route Tables.
- Click Create route table.
- Choose `<YOUR_NAME>-vpc` as the VPC.
- Click Create route table.
- Select the route table you just created and go to the "Routes" tab.
- Click Edit routes.
- Click Add route, and set the following values:
    - Destination: `0.0.0.0/0`
    - Target: NAT Gateway, `<YOUR_NAME>-nat-gateway`
    - Click Save changes.
- Select the route table you just created and go to the "Subnet Associations" tab.
- Click Edit subnet associations.
- Select `<YOUR_NAME>-private` and click Save.
- 




## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

## Conclusion

Congratulations! You have successfully created a VPC with public and private subnets.