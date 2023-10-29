# Work with AWS VPC Flow Logs for Network Monitoring

### Overview

Monitoring network traffic is a critical component of security best practices to meet compliance requirements, investigate security incidents, track key metrics, and configure automated notifications.
AWS VPC Flow Logs captures information about the IP traffic going to and from network interfaces in your VPC. In this hands-on lab, we will set up and use VPC Flow Logs published to Amazon CloudWatch,
create custom metrics and alerts based on the CloudWatch logs to understand trends and receive notifications for potential security issues, and use Amazon Athena to query and analyze VPC Flow Logs
stored in S3.

### Depends On

- Basic AWS knowledge
- [login](../login/login.md)

## Duration

120 minutes

## Regions

- us-east-1 (N. Virginia)

## Steps

### Step 1: Create an S3 Bucket for VPC Flow Logs and VPC Flow Log to S3

- Navigate to S3.
- Copy the cloud_user account ID (the number shown after cloud_user in the menu bar at the top right of the screen) to your favorite text editor, and delete the dashes in the ID. We'll need this
  number later.
- Click Create bucket.
- Enter a unique bucket name (e.g., vpc-flow-logs-ACCOUNT ID-YOUR INITIALS). If the name you entered exists, try a different name.
- Ensure AWS Region is set to US East.
- Scroll down, and click Create bucket.
- Select the checkbox next to the name of bucket you just created.
- In the upper right corner, click Copy ARN. Paste the ARN in your favorite text editor. We will use the S3 ARN in an upcoming task.

### Step 2: Create VPC Flow Log to S3

**In a new browser tab, navigate to VPC.**

- In the left navigation menu, click Your VPCs.
- Select the Academy VPC.
- Select the Flow logs tab toward the bottom.
- Click Create flow log, and set the following values:
    - Filter: Select All.
    - Destination: Select Send to an Amazon S3 bucket.
    - S3 bucket ARN: Paste the S3 bucket ARN you copied earlier.
- Click Create flow log.
- Select the Flow logs tab again.
- Verify the flow log shows an Active status.
- Select the hyperlink in the Destination name field.
- In the S3 bucket browser tab that opens, click the Permissions tab.
- Click Bucket Policy.
- Notice the bucket path in the policy includes AWSLogs.

**Note:** It can take 5-15 minutes before logs start to show up, so let's move on while we wait for that to happen.

### Step 3: Create CloudWatch Log Group

- In a new browser tab, navigate to CloudWatch.
- In the left navigation menu, click Log groups.
- Click Create log group.
- Enter VPCFlowLog for the log group name.
- Click Create.

### Step 4: Create VPC Flow Log to CloudWatch

- Back in the VPC browser tab, ensure you are in the flow logs tab for the Academy VPC (Your VPCs in the left navigation menu > select the Academy VPC > select the Flow Logs tab).
- Click Create flow log, and set the following values:
- Filter: Select All.
- Destination: Select Send to CloudWatch Logs.
- Destination log group: Select VPCFlowLogs.
- IAM role: Select the role with DeliverVPCFlowLogsRole in the name.
- Click Create flow log.
- In the Flow logs tab, verify the flow log shows an Active status.
- Select the hyperlink in the Destination name field.
-

**Note:** It can take 5-15 minutes before logs start to show up, so let's move on while we wait for that to happen.

### Step 5: Generate Traffic

Open a terminal session, and log in to the EC2 instance via SSH using the credentials provided. Observe that SSH is enabled.
Exit the terminal.
Back in the AWS console, navigate to EC2 in a new browser tab.
Select Instances (running).
Select the checkbox next to the instance with the name Web Server.
Click on the Security tab.
Scroll down to Inbound rules; Observe that SSH is enabled for all source addresses.
In the upper right corner, click Actions > Security > Change security groups.
Click Remove next to the associated security group.
In the Select security groups search bar, search for and select the one that says SecurityGroupHTTPOnly.
Click Add security group.
Click Save.
Select the checkbox next to the Web Server instance again.
Click on the Security tab.
Scroll down to Inbound rules; Observe that only port 80 is open.
Navigate back to your terminal and attempt to log in to the EC2 instance via SSH using the credentials provided — we expect this to timeout since we just selected a security group with no SSH access.
Cancel the SSH command after 15 seconds.
Return to EC2 in the AWS console.
Select the checkbox next to the Web Server instance again.
In the upper right corner, click Actions > Security > Change security groups.
Click Remove next to the associated security group.
In the Select security groups search bar, search for and select the one that says SecurityGroupHTTPAndSSH.
Click Add security group.
Click Save.
Select the checkbox next to the Web Server instance again > Security tab > Inbound rules; observe that port 22 and port 80 are open.
Navigate back to your terminal and log in to the EC2 instance via SSH using the credentials provided. Observe that SSH is enabled.

### Step 6: Create CloudWatch Log Metric Filter

Navigate to CloudWatch.

Click Log groups in the left navigation menu.

Under Log groups, click VPCFlowLog; if you don't see any data yet, pause the video and wait a few minutes until data appears.

Click on the Metric filters tab.

Click Create metric filter.

Enter the following in the Filter Pattern field to track failed SSH attempts on port 22:

[version, account, eni, source, destination, srcport, destport="22", protocol="6", packets, bytes, windowstart, windowend, action="REJECT", flowlogstatus]
In the Select log data to test dropdown, select Custom log data.

Enter the following in the text box:

2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 22 6 1 40 1563108188 1563108227 REJECT OK
2 086112738802 eni-0d5d75b41f9befe9e 182.68.238.8 172.31.83.158 42227 22 6 1 44 1563109030 1563109067 REJECT OK
2 086112738802 eni-0d5d75b41f9befe9e 42.171.23.181 172.31.83.158 52417 22 6 24 4065 1563191069 1563191121 ACCEPT OK
2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 80 6 1 40 1563108188 1563108227 REJECT OK
Click Test Pattern.

Click on the Show test results link. You should see 2 of the 4 records matching.

Click Next.

For Filter name, enter destination-port22-rejects.

Under Metric details, set the following values:

Metric namespace: Enter SSH-failures.
Metric name: Enter SSH-failures.
Metric value: Enter 1.
Click Next.

Click Create metric filter.

### Step 7: Create Alarm Based on the Metric Filter

In the Metric filters tab, click on the checkbox in the upper right corner of the destination-port-22-rejects metric filter box.

In the upper right corner, click on the Create alarm hyperlink.

In the new browser tab, scroll down to Conditions.

Set Whenever SSH-failures is... to Greater/Equal.

Set Define the threshold value to 1.

Click Next.

On the Notification page, set the following values:

Send a notification to the following SNS topic: Select Create new topic.
Create a new topic...: Enter PROD-Alert-<YOUR INITIALS>.
Email endpoints that will receive the notification...: Enter your email address.
Click Create topic.

Click Next.

Set the Alarm name as SSH-reject.

Click Next.

Click Create alarm.

You will receive an email notification asking you to confirm your subscription. Click the Confirm Subscription link in the email.

### Step 8: Generate Traffic for Alerts

In the terminal, log in to the EC2 instance via SSH using the credentials provided. Observe that SSH is enabled for all source addresses.
Exit the terminal.
Navigate to the EC2 browser tab.
Select the checkbox next to the Web Server instance.
In the upper right corner, click Actions > Security > Change security groups.
Click Remove next to the associated security group.
In the Select security groups search bar, search for and select the one that says SecurityGroupHTTPOnly.
Click Add security group.
Click Save.
Attempt to log in to the EC2 instance via SSH using the credentials provided — we expect this to timeout since we just selected a security group with no SSH access.
Cancel the SSH command after 15 seconds.
Return to EC2 in the AWS console.
Select the checkbox next to the Web Server instance.
Click Actions > Security > Change security groups.
Click Remove next to the associated security group.
In the Select security groups search bar, search for and select the one that says SecurityGroupHTTPAndSSH.
Click Add security group.
Click Save.
In your terminal, log in to the EC2 instance via SSH using the credentials provided; observe that SSH is now enabled.

### Step 9: Use CloudWatch Insights

Navigate to CloudWatch.
Click Logs Insights in the left navigation menu.
In the Select a log group dropdown menu, select VPCFlowLog.
Click Run query. After a few moments, we'll see some data start to populate.

### Step 10: Configure VPC Flow Logs Table and Partition in Athena

Record Reference Information to Be Used in Athena Queries
Note: Before attempting to run a query in Athena, you have to specify an s3 bucket for the results to be saved before running a query.

Navigate to S3 in a new browser tab.
Open your log bucket that you created earlier.
Copy your log bucket name to a text editor for later use.
Open the AWSLogs folder.
Open the {ACCOUNT_ID} folder.
Copy the account ID to a text editor for later use if you didn’t save it earlier.
Open the vpcflowlogs folder.
Open the us-east-1 folder.
Open the {YEAR} folder.
Open the {MONTH} folder.
Open the {DAY} folder.
Write down the {YEAR}/{MONTH}/{DAY} using the latest {DAY} shown.

### Step 11: Create the Athena Table

Navigate to Athena in a new browser tab.
Under Get started, select Query your data with Trino SQL, and click Launch query editor.
If you come to a page with a Get Started button, click on it. Otherwise, skip this step.
If a Tutorial popup window shows up, click on the X in the upper right of the screen to close it. You can return to the tutorial later by selecting it in the upper right-hand menu.
In the banner at the top stating Before you run your first query, you need to set up a query result location in Amazon S3, click Edit settings.
Click Browse S3.
Select the vpc-flow-logs bucket.
Select Choose.
Click Save.
Click on the Editor tab.
Paste the following DDL code in the Query 1 window:
CREATE EXTERNAL TABLE IF NOT EXISTS default.vpc_flow_logs (
version int,
account string,
interfaceid string,
sourceaddress string,
destinationaddress string,
sourceport int,
destinationport int,
protocol int,
numpackets int,
numbytes bigint,
starttime int,
endtime int,
action string,
logstatus string
)  
PARTITIONED BY (dt string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '
LOCATION 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/'
TBLPROPERTIES ("skip.header.line.count"="1");
Update {your_log_bucket} and {account_id} in the query window with the values from this hands-on lab.
Click Run. You should see a Query successful. message once this has finished executing.

### Step 12: Create Partitions to Be Able to Read the Data

Next to the Query 1 tab, click on the + icon to open a new query.

Paste the following code in a new query window:

ALTER TABLE default.vpc_flow_logs
ADD PARTITION (dt='{Year}-{Month}-{Day}')
location 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/{Year}/{Month}/{Day}';
Update the following elements in the query window with the values from this hands-on lab:

{your_log_bucket}
{account_id}
{Year},{Month}
{Day}
Click Run. You should receive a Query successful. message.

### Step 13: Analyze VPC Flow Logs Data in Athena

Next to the Query 2 tab, click on the + icon to open a new query.

Run the following query in the new query window:

SELECT day_of_week(from_iso8601_timestamp(dt)) AS
day,
dt,
interfaceid,
sourceaddress,
destinationport,
action,
protocol
FROM vpc_flow_logs
WHERE action = 'REJECT' AND protocol = 6
order by sourceaddress
LIMIT 100;
Click Run. Scroll down to review the results.

## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

## Conclusion

Congratulations! You have successfully launched an EC2 instance within a custom VPC, ensuring connectivity and security for Alfredo's Pizza website server. You are now equipped with foundational
knowledge on AWS networking and compute services.