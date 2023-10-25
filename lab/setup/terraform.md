[<< back to main index](../../README.md)

---

# Installing Terraform on Ubuntu Using HashiCorp's Repository

## Overview

In this lab, participants will learn how to securely install Terraform on an Ubuntu machine using HashiCorp's official Debian package repository. By the end of the lab, Terraform will be installed,
and participants will be able to verify its installation.

## Depends On

- [AWS CLI](../setup/aws-cli.md)

## Duration

30 minutes

## Regions

- N/A

### Step 1 : Prepare the System

1. Open the terminal.
2. Ensure that your system is up-to-date and you have the necessary packages installed:

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

### Step 2 : Install and Verify HashiCorp's GPG Key

Install the HashiCorp GPG key:

```bash
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

**Tip**: Refer to the [Official Packaging Guide](https://www.terraform.io/docs/cli/install/apt.html) for the latest public signing key. Verification details can also be found
on [Security at HashiCorp](https://www.hashicorp.com/security) under Linux Package Checksum Verification.

### Step 3 : Add HashiCorp Repository

Add the official HashiCorp repository to your system:

```bash
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

Update the package list:

```bash
sudo apt update
```

### Step 4 : Install Terraform

Install Terraform from the HashiCorp repository:

```bash
sudo apt-get install terraform
```

### Step 5 : Verify Installation

1. To ensure Terraform was installed successfully, check its version:
   ```bash
   terraform -v
   ```
2. You should see the version of Terraform displayed.

## Conclusion

Congratulations! You've securely installed Terraform on your Ubuntu machine using HashiCorp's official Debian package repository. With Terraform ready, you can now begin to define and provide
infrastructure as code.
