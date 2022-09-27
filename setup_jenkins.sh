#!/bin/bash

# run on EC2 as ubuntu user

echo "Installing Jenkins..."
sleep 2

sudo apt update && sudo apt install default-jre
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update && sudo apt install jenkins -y

sleep 2 
echo "Jenkins installation completed!"
sleep 1
echo "Starting Jenkins..."
sleep 2

sudo systemctl start jenkins

sleep 2
echo "Checking Jenkins status..."
sleep 2

sudo systemctl status jenkins

# Create and activate a jenkins user
echo
echo "Creating a jenkins user"

sudo passwd jenkins

sleep 2
echo "Activating jenkins user..."
sleep 2

sudo su - jenkins -s /bin/bash