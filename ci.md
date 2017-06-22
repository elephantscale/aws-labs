<link rel='stylesheet' href='assets/css/main.css'/>

[<< back to main index](README.md)

---

# Configure CI

### Overview
Configure source control and Jenkins on AWS

### Depends On
None

### Run time
30 mins


## Step 1: Configure Git repository
* Start AWS instance.
* Install and configure Git
* Setup permissions (https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server)


## Step 2: Configure Jenkins

* Start AWS instance (alternatively, use the same as in Step 1 above)
* Run Jenkins with this command
```bash
   java -jar jenkins.war  
```


## Step 3: Configure CI
* Make Jenkins poll from Git
* Make Jenkins build on changes in Git


## Discussion
* Discuss other options of setting this  up