#!/bin/bash


#Installing NGINX
yum update 
amazon-linux-extras install nginx1
service nginx start
systemctl enable nginx.service

#Install Python updated the openssl version to 11
pip3 install boto3 


