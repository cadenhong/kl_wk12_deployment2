#!/bin/bash

# Script to install and set up EB CLI
# For Deployment 2 - run this on the EC2 as jenkins user

echo "Downloading EB CLI..."
sleep 2

pip install awsebcli --upgrade --user

sleep 1
echo "Exporting PATH variable to include Jenkins bin location..."

export PATH="/var/lib/Jenkins/.local/bin:$PATH"

sleep 1
echo "Checking EB version..."
sleep 1

eb --version