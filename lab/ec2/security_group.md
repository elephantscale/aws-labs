[<< back to main index](../../README.md)

---

# Creating and Managing Security Groups

## Overview:

This lab will provide hands-on experience with creating and managing AWS security groups to secure resources such as EC2 instances.

## Duration

1 hour and 45 minutes

## Steps

### Step 1: Sign in to AWS Management Console

Open the AWS Management Console and log in with your credentials.

### Step 2: VPC

### Step 2.1: Create a VPC

* Go to VPC > Your VPCs.
* Choose Create VPC, and configure the subsequent settings:
* Choose: `VPC Only`
* Assign the Name tag as: `<YOUR_NAME>_my-sg-vpc`
* Set the IPv4 CIDR block to: `10.0.0.0/16`
* Retain the default values for IPv6 CIDR block and Tenancy.
* Select Create VPC.

### Step 2.2: Create a Public Subnet

* Click Subnets in the left-hand menu.
* Click Create subnet, and set the following values:
* VPC ID: `<YOUR_NAME>_my-sg-vpc`
* Subnet name: `<YOUR_NAME>_my-sg-public-subnet`
* Availability Zone: `us-east-1a`
* IPv4 CIDR block: `10.0.0.0/24`
* Click Create subnet.

### Step 2.3: Create Routes and Configure Internet Gateway

* With `<YOUR_NAME>_my-sg-public-subnet` selected, click Actions > Edit subnet settings.
* Check the box to Enable auto-assign public IPv4 address.
* Click Save.
* Click Internet Gateways in the left-hand menu.
* Click Create internet gateway.
* Set Name tag as `<YOUR_NAME>_my-sg-internet-gateway`.
* On the next screen, click Actions > Attach to VPC.
* In the Available VPCs dropdown, select `<YOUR_NAME>_my-sg-vpc`.
* Click Attach internet gateway.
* Click Route Tables in the left-hand menu.
* Select the route table related to `<YOUR_NAME>_my-sg-vpc` and go to the "Routes" tab. (By the VPC id)
* On the next screen, click Edit routes.
* Click Add route, and set the following values:
* Destination: `0.0.0.0/0`
* Target: Internet Gateway, `<YOUR_NAME>_my-sg-internet-gateway`
* Click Save changes.

### Step 3: Navigate to the EC2 Dashboard

- Click on “EC2” under the “Compute” section under “Services”.
- In the EC2 Dashboard's left navigation pane, click on “Security Groups”.

### Step 4: Create a New Security Group

- Return to the EC2 Dashboard and click on “Instances”.
- Click on the “Create Security Group” button.
- **Name your Security Group**: Provide a descriptive name, e.g., `<YOUR_NAME>_my_sg`.
- **Description**: Add a brief description, e.g., "Security group for web servers".
- **VPC**: Choose `<YOUR_NAME>_my-sg-vpc` to associate with this security group.
- **Add Rules**:
    - Under the "Inbound rules" tab, click "Add rule".
        - Select `RDP` from the "Type" dropdown and `0.0.0.0/0` for the "Source" field.
    - Click “Add rule”.
    - Select `ALL ICMP - IPv4` from the "Type" dropdown and `0.0.0.0/0` for the "Source" field.
- Click “Create security group”.

### Step 5: Create A new EC2 Instance

- Click the “Launch Instance” button.
- Enter `<YOUR_NAME>_my_ec2` under “Name”.
- **Choose an Amazon Machine Image (AMI)**: Select the "Windows".
- **Choose an Instance Type**: Select "t2.xlarge".
- **Key Pair**:
    - Choose the key pair you created in the previous labs or create a new one.
- Click on Edit in front of Network Settings.
    - Make sure you are selecting `<YOUR_NAME>_my-sg-vpc` under VPC.
    - Choose `Select existing security group` and select `<YOUR_NAME>_my_sg` from the dropdown.
- Click “Launch Instances”.

### Step 6: Access the EC2 Instance

- Return to the EC2 Dashboard and click on “Instances”.
- Wait until `<YOUR_NAME>_my_ec2` state changes to "running" and checks pass.
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

### Step 7: Explore

- Open a console (cmd) on your personal computer.
- Ping the public IP of the instance you just created.
    - You should see a response.
    - This is because we allowed ICMP traffic in the security group.
- Go to `Security Groups` in the EC2 Dashboard.
- Select `<YOUR_NAME>_my_sg` and click on the "Inbound Rules" tab.
- Click "Edit inbound rules".
- Delete the rule for `ALL ICMP - IPv4`.
- Click "Save rules".
- Observe that you can no longer ping the instance but you can still RDP into it.

## Clean Up

Make sure to delete the following resources:

- EC2 instance `<YOUR_NAME>_my_ec2`
- Security group `<YOUR_NAME>_my_sg`
- VPC `<YOUR_NAME>_my-sg-vpc`
- Internet Gateway `<YOUR_NAME>_my-sg-internet-gateway`

### Conclusion:

Congratulations! You've successfully created, modified, associated, and deleted an AWS security group. This foundational knowledge is crucial when securing AWS resources, ensuring that only legitimate
traffic gets through while potentially malicious traffic is kept out. Always remember to review and minimize open ports, limiting access to only what's necessary.