<link rel='stylesheet' href='assets/css/main.css'/>

[<< back to main index](README.md)

---

# Execute a CloudFormation template

### Overview
Execute a template
Write your own

### Depends On
None

### Run time
30 mins


## Step 1: Execute a given template

1. Go to Services -> CloudFormation.

2. Click on Create Stack

3. Select a template: LAMP stack.

4. Enter in parameters for LAMP stack, such as DB Password, DB Usersname.

5. You MUST enter a security key.  Create on if needed.

6. Under tags, crate a tag called "Name" with your name, so you can identify it.

7. Watch the results.  You should see "CREATE IN PROGRESS" until it is ready.  If there are errors, you will see a rollback -- this is due to some kind of problem in your parameters.   If all is well, you should
see CREATE_COMPLETE.

8. Go to the outputs.  You should see a URL that looks something like this:

http://ec2-35-163-244-124.us-west-2.compute.amazonaws.com  (of course, yours will be different).

Select this in your browser and you should see something like this:

```bash
Welcome to the AWS CloudFormation PHP Sample
```


## BONUS: Create your own template.

