#!/bin/bash

## -- start config

profile=es-training-sujee
region=us-west-2

# if you don't have pwgen installed, just set a password manually here, just alpha-numeric chars please (no special chars like $ ! ~)
password="xky090ljXvU"
password=$(pwgen -n -s 14 1)

group_name=students

## -- end config


#echo "using pasword : $password"


# generate a few users
for i in {1..10}
do
    student="student$i"
    # create user
    aws --profile "$profile" \
    iam create-user --user-name "$student"

    # change login
    aws --profile "$profile" \
        iam create-login-profile --no-password-reset-required \
        --user-name "$student"  --password "${password}"

    # add to student group
    aws --profile "$profile" \
        iam add-user-to-group --user-name "$student" --group-name "$group_name"

    echo "== $i :  user = $student   password = $password"

done
