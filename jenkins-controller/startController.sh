##!/bin/bash

# TODO Uncomment below command to pass SSH key for private git repository
# Export SSH key to access private repository 
# export SSH_PRIVATE_KEY=$(cat /path/to/private_key)

# Run custom docker image to start jenkins server 
docker run -p  8080:8080 -p 50000:50000 --env-file controller.env mandarnilange/jenkins-controller

# TOOD Use below command to map a volume to local drive for running jenkins 
# docker run --name my_jenkins_controller -p  8080:8080 -p 50000:50000 --env-file controller.env -v /var/agent/jenkis:/var/jenkins_home/ my_jenkins_controller
