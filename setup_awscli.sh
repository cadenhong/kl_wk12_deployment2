#!/bin/bash

# Script to install and set up AWS CLI
# For Deployment 2 - run this on the EC2 as Ubuntu user

echo "Downloading AWS CLI..."
sleep 2

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sleep 1
echo "Installing unzip package to unzip downloaded file..."
sleep 1

sudo apt install unzip
unzip awscliv2.zip

sleep 2
echo "Installing python3-pip package to install EB CLI later..."
sleep 1

# This is a required package to be able to install EB CLI on jenkins user later
sudo apt install python3-pip -y

sleep 2
echo "Installing AWS CLI..."
sleep 2

sudo ./aws/install

sleep 2
echo "AWS CLI installation completed!"
sleep 1
echo "Checking AWS CLI version..."
sleep 1

aws --version

sleep 1
echo "Configuring AWS..."
sleep 2

aws configure