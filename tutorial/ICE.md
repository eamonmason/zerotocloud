# Build and Bake <a href="https://github.com/Netflix/ice" target="_blank">ICE</a>

Ice provides a birds-eye view of our large and complex cloud landscape from a usage and cost perspective. 

![](images/ice.png)

## Billing Reports

The difficulty in settings up ICE during a tutorial is that the billing reports that ICE needs to process won't be available for a couple of hours.
To start generating the Billing Reports, follow these instructions.
 
1. Open up two tabs in the AWS console
2. tab1: Enable Billing Reports on [https://console.aws.amazon.com/billing/home?#/preferences](https://console.aws.amazon.com/billing/home?#/preferences)
3. tab2: Create S3 Bucket name to something like zerotocloud.billing [https://console.aws.amazon.com/s3/home?region=us-west-2](https://console.aws.amazon.com/s3/home?region=us-west-2)
4. tab1: enter bucket name (don’t click verify yet),
5. tab1: click sample policy, copy all of the json text to your clipboard.
6. tab2: add bucket policy under bucket permissions
7. tab2: paste json from clipboard and save
8. tab1: verify

## Working Bucket for ICE

Create another S3 bucket for ICE to put its working files in

## Bake ICE

We are going to bake two separate AMIs, one for the ICE processor and one for the ICE reader/UI. Not the properties in the build, and ensure that you set one for the billing bucket from above and another bucket for ICE to put working files in.

    cd ~/zerotocloud
	./gradlew -Ptype=processor -Pbillingbucket=<aws-billing-reports-bucket> -Picebucket=<ice-working-bucket> :ice:buildDeb
    sudo aminate -e ec2_aptitude_linux -b ubuntu-base-ami-ebs ice/build/distributions/ice_processor_1.0.0_all.deb
	./gradlew -Ptype=reader -Pbillingbucket=<aws-billing-reports-bucket> -Picebucket=<ice-working-bucket> :ice:buildDeb
	sudo aminate -e ec2_aptitude_linux -b ubuntu-base-ami-ebs ice/build/distributions/ice_reader_1.0.0_all.deb

The baking takes a LONG time. Be patient, it will get there in the end.

## Deploy ICE.

ICE has two separate deployments, so you will do the following just like you did for Asgard, but once for the processor and once for the reader. 
Return to [Step 13](AsgardStandalone.md) and perform the "Create Application", "Create an ELB", "Create Auto Scaling Group", and "View instance" pieces.
Everything from the Health Check URL to the port numbers can stay the same, just use the name "ice".


1. Naviate to Asgard. This can be done by finding the DNS Name from the end of [Step 13](AsgardStandalone.md) or finding the Asgard ELB and using the DNS Name.
2. Follow "Create Application", using the name "ice" instead of "asgard".
3. Follow "Create an ELB", using the name "ice" instead of "asgard".
4. Follow "Create Auto Scaling Group" using the name "ice" instead of "asgard".
5. Follow "View instance" to get the DNS Name for ice's ELB, i.e. _ice--frontend_. It can ICE quite a few minutes to start up.
6. Using that DNS Name, visit _http://*ELB DNS name*/_. 

