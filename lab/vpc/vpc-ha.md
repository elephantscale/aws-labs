[<< back to main index](../../README.md)

---

# Create a Highly Available VPC

### Overview

In this lab, you will set up a highly available VPC in AWS. You will be working with VPC configurations, subnets, internet gateways, route tables, and security groups, and you will also enable logging
to an S3 bucket.

### Depends On

- Basic AWS knowledge
- [login](../login/login.md)

## Duration

90 minutes

## Regions

- us-east-1 (N. Virginia)

## Steps

### Step 1: Create the VPC

* Navigate to VPC using the Services menu or the unified search bar.
* In the sidebar menu, select Your VPCs.
* On the right, click Create VPC.
* Configure the VPC settings section:
* Resources to create: Select VPC only.
* Name tag: In the text box, enter LabVPC.
* IPv4 CIDR: In the text box, enter 10.20.0.0/16.
* Leave all the other default settings and click Create VPC.
* The VPC is created and its details are automatically displayed.

### Step 2: Create the Subnets

* In the sidebar menu, select Subnets.
* On the right, click Create subnet.
* In the VPC ID field, use the dropdown to select your VPC.
* Configure the Subnet settings section for public subnet 1:
* Subnet name: In the text box, enter Public1.
* Availability Zone: Use the dropdown to select US East (N.Virginia)/us-east-1a.
* IPv4 CIDR block: In the text box, enter 10.20.1.0/24.
* Toward the bottom of the page, click Add new subnet.
* Configure the Subnet settings section for public subnet 2:
* Subnet name: In the text box, enter Public2.
* Availability Zone: Use the dropdown to select US East (N. Virginia)/us-east-1b.
* IPv4 CIDR block: In the text box, enter 10.20.2.0/24.
* Toward the bottom of the page, click Add new subnet again.
* Configure the Subnet settings section for private subnet 1:
* Subnet name: In the text box, enter Private1.
* Availability Zone: Use the dropdown to select US East (N. Virginia)/us-east-1a.
* IPv4 CIDR block: In the text box, enter 10.20.3.0/24.
* Toward the bottom of the page, click Add new subnet one more time.
* Configure the Subnet settings section for private subnet 2:
* Subnet name: In the text box, enter Private2.
* Availability Zone: Use the dropdown to select US East (N. Virginia)/us-east-1b.
* IPv4 CIDR block: In the text box, enter 10.20.4.0/24.
* At the bottom of the page, click Create subnet.
* The four subnets take a moment to finish creating.

### Step 3: Build an Internet Gateway

* In the sidebar menu, select Internet gateways.
* On the right, click Create internet gateway.
* In the Name tag field, enter LabIGW.
* Click Create internet gateway.
* The internet gateway takes a moment to finish building.
* After the internet gateway is created, use the breadcrumb along the top of the page to select Internet gateways.
* Check the checkbox to the left of your LabIGW gateway.
* On the right, use the Actions dropdown to select Attach to VPC.
* In the Available VPCs field, click into the text box and select your LabVPC VPC.
* Click Attach internet gateway.
* The internet gateway is attached to your VPC.

### Step 4: Create the Route Table and Associate the Public Subnets

* In the sidebar menu, select Route tables.
* In the top right corner, click Create route table.
* Configure the Route table settings section:
* Name: In the text box, enter PubRT.
* VPC: Use the dropdown to select your LabVPC VPC.
* Click Create route table.
* The route table is created and its details display automatically.
* On the right, use the Actions dropdown to select Edit subnet associations.
* Check the checkboxes to the left of the Public1 and Public2 subnets.
* Click Save associations.

### Step 5: Update the Routes to Send Traffic to the Internet Gateway

* From the route table details, ensure the Routes tab is selected.
* On the right, click Edit routes.
* Click Add route.
* In the Destination field, enter 0.0.0.0/0.
* In the Target field, select Internet Gateway, and then select your LabIGW gateway.
* Click Save changes.

### Step 6: Associate the Private Subnets with the Default VPC

* Use the breadcrumb along the top of the page to select Route tables.
* Check the checkbox to the left of the default VPC (indicated as the main VPC).
* From the route table details, select the Subnet associations tab.
* On the right, click Edit subnet associations.
* Check the checkboxes to the left of the Private1 and Private2 subnets.
* Click Save associations.
* Create the PublicSG and PrivateSG Security Groups
*

### Step 7: Create the PublicSG Security Group

* In the sidebar menu, select Security groups.
* On the right, click Create security group.
* Fill in the Basic details section:
* Security group name: In the text box, enter PublicSG.
* Description: In the text box, enter pubsg.
* VPC: Click into the field and select your LabVPC VPC.
* In the Inbound rules section, click Add rule.
* Fill in the rule details:
* Type: Use the dropdown to select HTTPS.
* Source: Use the dropdown to select Anywhere-IPv4.
* Click Add rule again.
* Fill in the rule details:
* Type: Use the dropdown to select HTTPS.
* Source: Use the dropdown to select Anywhere-IPv6.
* At the bottom of the page, click Create security group.
* After the security groups are created, use the breadcrumb along the top of the page to select Security Groups.

### Step 8: Create the PrivateSG Security Group

* On the right, click Create security group.
* Fill in the Basic details section:
* Security group name: In the text box, enter PrivateSG.
* Description: In the text box, enter privatesg.
* VPC: Click into the field and select your LabVPC VPC.
* In the Inbound rules section, click Add rule.
* Fill in the rule details:
* Type: Use the dropdown to select All traffic (you can also type All traffic into the field to narrow the dropdown results).
* Source: Leave the Custom default. In the search box to the right of Custom, select your PublicSG security group.
* At the bottom of the page, click Create security group.

### Step 9: Enable Logging of All IP Traffic to a Created S3 Bucket

* In the sidebar menu, select Your VPCs.
* Check the checkbox to the left of your LabVPC VPC.
* On the right, use the Actions menu to select Create flow log.
* Fill in the Flow log settings section:
* Name: In the text box, enter LabVPCFlowLogs.
* Filter: Select All.
* Maximum aggregation interval: Select 10 minutes.
* Destination: Select Send to Amazon S3 bucket.
* To get the S3 bucket ARN, open S3 in a new tab using the Services menu or the unified search bar.
* In the S3 Management Console, you should see one bucket.
* Select the bucket name.
* Along the top of the page, select the Properties tab.
* In the Bucket overview section, copy the ARN.
* Navigate back to the VPC Management Console tab and paste your copied ARN into the S3 bucket ARN field.
* Leave all the other default settings, and click Create flow log.

## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

## Conclusion

Congratulations! You've built a highly available VPC infrastructure, complete with route tables, internet gateway, security groups, and logging