# Jenkins as a Code (JCasC) Example 
This example implements Jenkins as a code using [Jenkins Configuration as Code Plugin](https://github.com/jenkinsci/configuration-as-code-plugin). 

## Prerequisite  
- Docker 
- Linux / Mac machine with bash 
- Understanding of configuring Jenkins controllers and agents 

Objective of this demo is to demonstrate capability to run Jenkins controller and agent as docker image (instead running them on VM).

## Features 
This example uses official Jenkins docker images [jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins) and [jenkins/inbound-agent](https://hub.docker.com/r/jenkins/inbound-agent) as base images. 

Implemented features 
- Script to create Jenkins controller docker image
- configuration of Jenkins through `jenkins.yaml` 
  - Two users setup `admin` and `readonly` (password same as username) 
  - Access control for users
  - Two jobs setup for running through [JOB DSL Plugin](https://plugins.jenkins.io/job-dsl/)
  - Permanent node setup `docker-agent2` 
  - Two views for `UI` and `Microservices` 
  - Global credential setup for `git` using `ssh` 
- Installation of required plugins (`plugins.txt`) 
- Script to create Jenkins Agent docker image 
- Shell scripts to build run controller and agent on linux/mac 

## Quick Start - Run Jenkins
Start the Jenkins controller 

```ssh
docker run -p  8080:8080 -p 50000:50000 -e CASC_JENKINS_CONFIG=/usr/share/jenkins/ -e MY_JENKINS_URL="http://host.docker.internal:8080/"  mandarnilange/jenkins-controller
```

Go to Jenkins web controller at `http://localhost:8080`, and identify secret for `docker-agent2`.  

Start Jenkins Agent 
```ssh
docker run --init -e JENKINS_URL=http://host.docker.internal:8080 -e JENKINS_AGENT_NAME=docker-agent2 -e JENKINS_AGENT_WORKDIR=/home/jenkins/agent -e JENKINS_SECRET=<Secret from master> mandarnilange/jenkins-inbound-agent
```
Go to Jenkins controller web and confirm agent is connected and jobs created to confirm job installation. 

In case, you want to build yourself from source and run locally then follow next section. 

## Build and Run Locally From Code  

### Jenkins Controller  
Following command will copy `jenkins.yaml`, copy `InitialConfig.groovy`, install plugins and build controller image [`mandarnilange/jenkins-controller`](https://hub.docker.com/repository/docker/mandarnilange/jenkins-controller/)

```ssh
$ cd jenkins-controller
$ ./buildControllerImage.sh 
```


Run controller image after setting up environemnt variables in `controller.env` (no changes needed in case run on Mac/linux)
- `CASC_JENKINS_CONFIG` for Configuration as Code plugin config file location 
- `MY_JENKINS_URL` to indicate host on which controller is running 
- `SSH_PRIVATE_KEY` set private key for access git/bitbucket private repository 

```ssh
$ ./startController.sh
```

### Jenkins Agent 
Following will build agent image [`mandarnilange/jenkins-inbound-agent`](https://hub.docker.com/repository/docker/mandarnilange/jenkins-inbound-agent/general)

```ssh
$ cd jenkins-agent
$ ./buildAgentImage.sh
```

Run agent image after setting up environment variables in `agent.env` (no changes needed in case run on Mac/linux)
- `JENKINS_URL` URL of controller 
- `JENKINS_SECRET` Secret to be taken from `docker-agent2` node configuration on cluster
- `JENKINS_AGENT_NAME` Name of agent configured in controller 
- `JENKINS_AGENT_WORKDIR` work directory for agent 

```ssh
$ cd jenkins-agent
$ ./runAgent.sh
```

## Next Steps 
You can extend this implementation - some key next steps that can be taken 
- Add more users: update `jenkins.yaml` and recreate image
- Setup more jobs: update `jenkins.yaml` and recreate image
- Setup external volume for persistent storage: update `startController.sh` 
- Access private git repository: setup `SSH_PRIVATE_KEY` before starting controller
- Install additional plugins: udpate `plugins.txt` and recreate image
- Add more agents: update `jenkins.yaml` and recreate image

Happy Learning! 

## References 
[mandarnilange/jenkins-controller](https://hub.docker.com/repository/docker/mandarnilange/jenkins-controller/general)

[mandarnilange/jenkins-inbound-agent](https://hub.docker.com/repository/docker/mandarnilange/jenkins-inbound-agent/general)

[Jenkins Configuration as Code Plugin](https://github.com/jenkinsci/configuration-as-code-plugin)

[DSL plugin docmentation](https://jenkinsci.github.io/job-dsl-plugin/) 

[Git repo - Jenkins as Code for this example](https://github.com/mandarnilange/jenkins-as-code)
