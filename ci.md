<link rel='stylesheet' href='assets/css/main.css'/>

[<< back to main index](README.md)

---

# Configure CI

### Overview
Configure source control with CodeCommit
Configure build with AWS CodeBuild

### Depends On
None

### Run time
30 mins


## Step 1: Configure CodeCommit
* Create a CodeCommit Repository

Go to Services-> CodeCommit

Createa named repository, studentX-repo.

You will need to also create git credentials for your user.  Go to:
  IAM -> USers -> Your User -> Security Credentials

  Scroll down to the bottom.  Genereate HTTPS credentials for your user.

  You will get a username and password like this:
  studenti-at-345402748775
  9E8hsRUjLK8uyoR0mzofrPkxp/dzBGvII3Z2BZw=

  Save these credentials.

* Clone the Repo on your ubuntu instance

Enter the username and password you just generated.

```console
$ git clone https://git-codecommit.us-west-2.amazonaws.com/v1/repos/tim-repository
Cloning into 'tim-repository'...
Username for 'https://git-codecommit.us-west-2.amazonaws.com': studenti-at-345402748775
Password for 'https://studenti-at-345402748775@git-codecommit.us-west-2.amazonaws.com':
warning: You appear to have cloned an empty repository.
Checking connectivity... done.
```

* Add some code to the project (choose any code that build)

You can use maven to generate a "hello world" app for you.

```console
  cd tim-repository
  mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

  mv my-app/src .  
  mv my-app/pom.xml .
  rm my-app
```

Test your maven build

```console
  mvn package
```

Create a buildspec.yml file in your repository directory with the following contents

```console
version: 0.2

phases:
  build:
    commands:
      - echo Build started on `date`
      - mvn test
  post_build:
    commands:
      - echo Build completed on `date`
      - mvn package
artifacts:
  files:
    - target/my-app-1.0-SNAPSHOT.jar

```

* Add the newly generated code to git

```bash
  $ git add pom.xml
  $ git add src
  $ git add buildspec.yml
  $ git status
  $ git commit
     ENTER COMMIT MESSAGE
  $ git push
```

  
* Verify this by viewing the code on AWS and observing commit results

## Step 2: Configure CodeBuild

* Create a build project on CodeBuild

Go to Services -> CodeBuild -> CreateProject

Name your project.  

* Make it pull from CodeCommit. Select your project you created in CodeCommit.



## Step 3: Do the build
* Push code to CodeCommit
* Observe the build in CodeBuild


## Discussion
* Discuss other options of setting this  up
