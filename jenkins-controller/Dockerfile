FROM jenkins/jenkins:lts
LABEL Maintainer="Mandar Nilange <mandarnilange@gmail.com>"
LABEL Description="This image runs Jenkins controller on docker and configures it"
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/jenkins.yaml

COPY files/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY files/jenkins.yaml /usr/share/jenkins/jenkins.yaml
COPY files/InitialConfig.groovy /usr/share/jenkins/ref/init.groovy.d/InitialConfig.groovy
COPY --chmod=777 --chown=jenkins:jenkins files/startup.sh /var/jenkins/ref/
RUN mkdir -p /var/jenkins_home/.ssh

USER jenkins

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/var/jenkins/ref/startup.sh" ]

