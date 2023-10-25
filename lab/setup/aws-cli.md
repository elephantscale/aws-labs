[<< back to main index](../../README.md)

---

# AWS CLI

### Overview

Although many tasks can be completed using the AWS web interface, Dev/Ops operations need to be
completed largely from the command line.

We will setup `awscli`  on Ubuntu to interact with AWS.

### Depends On

- [AWS Access Keys](../login/access-keys.md)

## Duration

45 minutes

## Regions

- N/A

## Steps

### Step 1 : Login to Machines

Each student will have 1 lab machine.

Login details and config file will be provided.

One can install the AWS CLI tools (if not already installed) on your system.

### Step 2: Install `awscli`

In order to interact with AWS, we need to install `awscli` on our machine.

Note: This will install awscli version 2 (latest version as of 2023-10-25)

```bash
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
aws --version
```

Output should be something like

```console
aws-cli/2.2.4 Python/3.8.8 Linux/5.4.0-1045-aws exe/x86_64.ubuntu.20 prompt/off
```

**Note:** For Windows and Mac installation, please refer to the [AWS CLI documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

### Step 2: Configure the command line

```bash
aws configure
  
AWS Access ID: <TYPE HERE>
AWS Secret Access Key: <TYPE HERE>
Default REgion: us-west-2
Default file type: (none is fine here)
```



