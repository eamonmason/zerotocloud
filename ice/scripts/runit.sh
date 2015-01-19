#!/bin/bash
. /home/ubuntu/.profile

cd /opt/ice
./grailsw -Dserver.port=7001 -Dice.s3AccessKeyId=@awsAccessKeyId@ -Dice.s3SecretKey=@awsSecretAccessKey@ run-app > /var/log/ice/ice.log 2>&1
