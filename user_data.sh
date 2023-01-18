#!/bin/bash

sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11
sudo amazon-linux-extras install epel -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo service jenkins start
sudo systemctl status jenkins
