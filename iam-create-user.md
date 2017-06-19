<link rel='stylesheet' href='assets/css/main.css'/>

[<< back to main index](README.md)

---

# IAM Create user

### Overview
Create Users in IAM

### Depends On
None

### Run time
10 mins


## Step 1 : Obtain login details
Ensure that the AWS CLI is installed and configured.

You will need your secret access key and your access key
configure with

```bash
aws --configure
```

## Step 2 : Create a User


``bash
aws iam create-user --user-name <NAME OF NEW USER>
```
The response will be as follows:

```console
{
    "User": {
        "UserName": "test01",
        "Path": "/",
        "CreateDate": "2017-06-17T20:49:38.244Z",
        "UserId": "AIDAJBOXNVQXVD4CGXZOS",
        "Arn": "arn:aws:iam::345402748775:user/test01"
    }
}
```

Note the UserId returned here.  In this case: AIDAJBOXNVQXVD4CGXZOS.



## Step 3 : Create an Access Key for the user

```bash
aws iam create-access-key --user-name test01
```

```console
{
    "AccessKey": {
        "UserName": "test01",
        "Status": "Active",
        "CreateDate": "2017-06-17T20:50:29.390Z",
        "SecretAccessKey": "uJAnCWZFnYKqRWWHRd0mnZijYUt/f2OYmi2ic26B",
        "AccessKeyId": "AKIAJ733I7IAIKEUBLZA"
    }
}
```

Note the response contains the secret access key.  Make note of this -- you will not be able to get
this another time! (for security reasons).

## Step 4 : Change the users login

We will not always log in at the command line, so let us set up user and password here.

```bash
    aws  iam create-login-profile --no-password-reset-required \
        --user-name test01  --password <ENTER NEW PWSSWORD HERE>
```

## Step 5 : Add the user to a group

Now we'll add the user to a group called students

```bash
    aws  iam add-user-to-group --user-name test01 --group-name "students"
```


## Step 5 : Add the user to a group

Let's list all the users to make sure our new user exists.

```bash
   aws iam list-users
