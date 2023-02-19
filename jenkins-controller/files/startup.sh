#!/bin/bash
# Generate known_hosts file for accessing private repo using SSH 
ssh-keyscan -t rsa bitbucket.org > /var/jenkins_home/.ssh/known_hosts 

# Start Jenkins server in image 
/usr/local/bin/jenkins.sh 