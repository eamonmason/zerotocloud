#!/bin/sh

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
echo export JAVA_HOME=$JAVA_HOME >> ~/.profile  
    
cd /opt/ice
./grailsw wrapper
./grailsw --refresh-dependencies compile

mkdir -p /opt/ice/ice-reader
mkdir -p /opt/ice/ice-working-directory
