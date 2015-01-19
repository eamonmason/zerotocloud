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

Create another S3 bucket for ICE to put its working files in.

## Bake ICE

We are going to bake two separate AMIs, one for the ICE processor and one for the ICE reader/UI. Note the properties that are required by gradle, and ensure that you set one for the billing bucket from above and another bucket for ICE to put working files in. The 'type' property can be either 'processor' or 'reader'. If none is supplied then 'type' defaults to 'processor'

    cd ~/zerotocloud
	./gradlew -Ptype=processor -Pbillingbucket=<aws-billing-reports-bucket> -Picebucket=<ice-working-bucket> :ice:buildDeb
    sudo aminate -e ec2_aptitude_linux -b ubuntu-base-ami-ebs ice/build/distributions/ice_processor_1.0.0_all.deb
	./gradlew -Ptype=reader -Pbillingbucket=<aws-billing-reports-bucket> -Picebucket=<ice-working-bucket> :ice:buildDeb
	sudo aminate -e ec2_aptitude_linux -b ubuntu-base-ami-ebs ice/build/distributions/ice_reader_1.0.0_all.deb

The baking takes a LONG time. Be patient, it will get there in the end.

## Deploy ICE.

ICE has two separate deployments: you deploy the AMI once for the processor and once for the reader. 

Deployment is not working with Asgard yet, so just simply deploy through the AMI through the AWS interface.

Vist the instance's public DNS Name on port 7001, i.e. _http://*instance DNS name*:7001/ice/dashboard/summary_
