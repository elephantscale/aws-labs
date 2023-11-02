[<< back to main index](../../README.md)

---

# Creating Amazon S3 Buckets, Managing Objects, and Enabling Versioning

## Overview:

In this hands-on lab, we will create two S3 buckets and verify public vs. non-public access to the buckets.

We will also enable and validate versioning based on uploaded objects.

## Duration

45 minutes

## Files:

- [cat1.jpg](cat1.jpg)
- [cat2.jpg](cat2.jpg)
- [cat3.jpg](cat3.jpg)

## Steps:

### Step 1: Public Bucket

#### Step 1.1: Create a public bucket

- Navigate to S3.
- Click Create bucket.
- Set the following values:
- Bucket name: Enter `<YOUR_NAME>-testlab-public-<random>`, where `<random>` is a random string of characters to make the bucket name globally unique.
- Region: Select US East (N. Virginia) us-east-1.
- Object Ownership: Select ACLs enabled and Bucket owner preferred.
- In the Block Public Access settings for this bucket section, uncheck the box for Block all public access.
- Check the box stating `I acknowledge that the current settings might result in this bucket and the objects within becoming public to confirm that we understand the bucket is going to be public`
- Leave the rest of the settings as their defaults.
- Click Create bucket.

#### Step 1.2: Upload an object to the public bucket

- Click Buckets in the link trail at the top.
- Select the public bucket name to open it.
- In the Objects section, click Upload.
- Click Add files.
- Navigate to the files you downloaded for the lab, and upload the `cat1.jpg` image.
- Leave the rest of the settings on the page as their defaults.
- Click Upload.
- After the file uploads successfully, click its name to view its properties.
- Open the Object URL in a new browser tab. You should receive an error message because although the bucket is public, the object is not.
- Back on the cat1.jpg page, select Object actions > Make public using ACL.
- Click Make public.
- Open the Object URL in a new browser tab again. This time, the image should load.

### Step 2: Private Bucket

#### Step 2.1: Create a private bucket

- On the Buckets screen, click Create bucket.
- Set the following values:
- Bucket name: Enter `<YOUR_NAME>-testlab-private-<random>`, where `<random>` is a random string of characters to make the bucket name globally unique (you can use the same string from your public
  bucket).
- Region: Select US East (N. Virginia) us-east-1.
- Leave the rest of the settings as their defaults.
- Click Create bucket.

#### Step 2.2: Upload an object to the private bucket

- Select the private bucket name to open it.
- In the Objects section, click Upload.
- Click Add files.
- Navigate to the files you downloaded for the lab, and upload the `cat1.jpg` image.
- Leave the rest of the settings on the page as their defaults.
- Click Upload.
- After the file uploads successfully, click its name to view its properties.
- Open the Object URL in a new browser tab. Since it's a private bucket, you'll see an error message.
- Back on the cat1.jpg page, select the Object actions dropdown.
- Note that the Make public using ACL option is grayed out, because the bucket is private, and we set the ownership to not use ACLs.

### Step 3: Enable Versioning on the Public Bucket and Validate Access to Different Versions of Files with the Same Name

#### Step 3.1: Enable Versioning

- Back on the public bucket page, click the **Properties** tab.
- In the **Bucket Versioning** section, click Edit.
- Click Enable to enable bucket versioning.
- Click **Save changes**.

#### Step 3.2: Upload a new version of the object

- Click the Objects tab.
- Click Upload, and then click **Add files**.
- Rename `cat3.jpg` to `cat1.jpg`
- Upload the new `cat1.jpg` image.
- Click **Upload**.
- After the file uploads successfully, click its name to view its properties.
- Click the **Versions** tab. You should see there are two versions of the cat1.jpg file.

#### Step 3.3: Validate access to different versions of the same file

- Select Object actions > Make public using ACL.
- Click **Make public**.
- Click the **Properties** tab.
- Open the **Object URL** in a new browser tab. This time, you should see the new image.
- Back on the `cat1.jpg` page, click the **Versions** tab.
- Click the **null** object.
- Open its Object URL in a new browser tab. You should see the original `cat1.jpg` image you uploaded.

## Clean Up

Make sure to clean up the resources you created in this lab to avoid incurring any unexpected charges.

### Conclusion:

Congratulations! You've successfully created a public and private S3 bucket, and enabled versioning on the public bucket.

[<< back to main index](../../README.md)