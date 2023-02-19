import jenkins.model.*
import jenkins.install.InstallState

// Set zero executors on the controller 
Jenkins.instance.setNumExecutors(0)

// Mark that initial setup is completed 
Jenkins.instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

// setting the Jenkins URL
url = System.env.MY_JENKINS_URL
urlConfig = JenkinsLocationConfiguration.get()
urlConfig.setUrl(url)
urlConfig.save()