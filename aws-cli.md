<link rel='stylesheet' href='assets/main.css'/>

[<< back to main index](README.md) 

---

# AWS CLI

### Overview

Although many tasks can be completed using the AWS web interface, Dev/Ops operations need to be
completed largely from the command line.


### Install the AWS CLI tools

One can install the AWS CLI tools (if not already installed) on your system.

```bash
pip install awscli --upgrade --user
```

Windows users can install the Windows MSI file as follows:
http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-windows.html


### Get your IAM account information

This should be supplied by your instructor, and will likely be studentXX, where
X is a number.

You will also need your AWS Public Key and Your Secret key.  This will 
have to also be given by your instructor.

### Configure the command line

```bash
  $ aws configure
  
    AWS Access ID: <TYPE THIS HERE>
    AWS Secret Access Key: <TYPE THIS HERE>
    Default REgion: us-west-2
    Default file type: (none is fine here) 
```

