[<< back to main index](../../README.md)

---

# Creating Amazon S3 Buckets, Managing Objects, and Enabling Versioning

## Overview:

## Duration

1 hour and 30 minutes

## Steps:

### Step 1: Set Up an S3 Bucket for Athena Query Results

1. Sign in to the **AWS Management Console**.
2. Navigate to the **S3 console** and create a new bucket.
    - Bucket name: `<YOUR_NAME>-athena-query-results`
    - Region: Select your preferred region.
    - All other settings can be left as default.
3. Create the bucket.
4. Upload `elb_log.csv` to the bucket.

### Step 2: Access AWS Athena

- Go to the **AWS Athena service** from the AWS Management Console.
  Before you run your first query, Athena will prompt you to set up a query result location in Amazon S3.

- In the **Settings** tab, set the query result location to the S3 bucket you created: `s3://<YOUR_NAME>-athena-query-results/`.
    - Click on Manage
    - Click on `Browse S3 buckets`
    - Select the bucket you created in the previous step (`<YOUR_NAME>-athena-query-results`)
    - Click on `Select`
    - Click on `Save`

### Step 3: Create a Database and Table in Athena

- In the Athena query editor, create a new database using the following SQL statement:

```sql
CREATE
DATABASE IF NOT EXISTS <YOUR_NAME>_athena_lab_db;
```

- Click on `Run query`

- Select the `<YOUR_NAME>_athena_lab_db` from the Database list in the Athena query editor.

- Define a table. For example, you can create a table for the ELB logs dataset:

```sql
CREATE
EXTERNAL TABLE IF NOT EXISTS elb_logs (
  request_timestamp string,
  elb_name string,
  request_ip string,
  request_port int,
  backend_ip string,
  backend_port int,
  request_processing_time double,
  backend_processing_time double,
  client_response_time double,
  elb_response_code string,
  backend_response_code string,
  received_bytes bigint,
  sent_bytes bigint,
  request_verb string,
  url string,
  protocol string,
  user_agent string,
  ssl_cipher string,
  ssl_protocol string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
)
   LOCATION 's3://<BUCKET_NAME>/';
```

Make sure to replace `<BUCKET_NAME>` with the S3 bucket.

### Step 4: Run Queries in Athena

- With the table created, you can now run SQL queries against your data. For example:

```sql
SELECT *
FROM elb_logs LIMIT 10;
```

- Try a more complex query to analyze the data, such as finding the total number of requests by HTTP method:
-

```sql
SELECT request_verb, COUNT(*) AS num_requests
FROM elb_logs
GROUP BY request_verb;
```

- Experiment with different queries to explore the dataset.

### Step 5: View Query Results

- After running queries, you can view the results directly in the Athena console.
- Athena also stores the query results in the S3 bucket you specified earlier.
- You can navigate to the S3 bucket to view the result files.

## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

### Conclusion:

Congratulations! You've successfully queried data in Amazon S3 using Amazon Athena.

[<< back to main index](../../README.md)