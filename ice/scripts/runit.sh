#!/bin/bash
. /home/ubuntu/.profile

cd /opt/ice
./grailsw -Dice.s3AccessKeyId=@awsAccessKeyId@ -Dice.s3SecretKey=@awsSecretAccessKey@ run-app
