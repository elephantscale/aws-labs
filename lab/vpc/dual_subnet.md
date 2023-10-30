[<< back to main index](../../README.md)

---

# Create a Virtual Private Cloud (VPC) with Private and Public Subnets

### Overview

In this lab, you will learn how to create a VPC with one public subnet and one private subnet in AWS. This setup allows you to have resources that are directly accessible from the internet (in the
public subnet) and resources that aren't (in the private subnet).

### Depends On

- [Login](../login/login.md)

## Duration

45 minutes

## Regions

- Depending on the lab, you may be asked to use a specific region. If not, please use `us-east-1 (N. Virginia)`.

## Steps

### 1. Sign in to the AWS Management Console:

Open the AWS Management Console and log in with your credentials.

### 2. Navigate to the VPC Dashboard:

Click on “VPC” under the “Networking & Content Delivery” section.

### 3. Create a New VPC:

- Click on “Your VPCs” on the left sidebar, then “Create VPC”.
- **Name tag**: `<YOUR_NAME>_my_vpc`
- **IPv4 CIDR block**: `10.0.0.0/16` (Or the CIDR block that the instructor provides)
- Leave the rest as defaults and click “Create VPC”.

### 4. Create a Public Subnet:

- Click on “Subnets” on the left sidebar, then “Create subnet”.
- **VPC**: Select `<YOUR_NAME>_my_vpc` from the dropdown.
- **Name**: `<YOUR_NAME>_public_subnet`
- **Availability Zone**: Choose an availability zone (e.g., us-east-1a).
- **IPv4 CIDR block**: `10.0.1.0/24` (Or the CIDR block that the instructor provides)
- Click “Create”.
- Select the subnet you just created and click “Actions” > “Edit subnet settings”.
    - Check the box to “Auto-assign public IPv4 address”.

### 5. Create a Private Subnet:

1. Following the same steps as above, create another subnet with:
    - **Name**: `<YOUR_NAME>_private_subnet`
    - **IPv4 CIDR block**: `10.0.2.0/24` (Or the CIDR block that the instructor provides)

### 6. Configure Internet Gateway:

- Navigate to “Internet Gateways” on the left sidebar and click “Create internet gateway”.
- **Name**: `<YOUR_NAME>_my_igw`
- Select the Internet Gateway you just created and click “Actions” > “Attach to VPC”.
- Attach it to `<YOUR_NAME>_my_vpc`.
- Go back to “Route Tables” on the left sidebar.
- Select the route table associated with `<YOUR_NAME>_my_vpc` and go to the "Routes" tab.
- Click “Edit routes” and add a route with:
  - **Destination**: "0.0.0.0/0"
  - **Target**: Select the Internet Gateway `<YOUR_NAME>_my_igw` you just created.
- Go to the “Subnet Associations” tab and associate this route table with the "PublicSubnet".

## Clean Up

Make sure to delete the following resources:

- VPC `<YOUR_NAME>_my_vpc`
- Internet Gateway `<YOUR_NAME>_my_igw`

## Conclusion

Congratulations! You have successfully created a VPC with public and private subnets.