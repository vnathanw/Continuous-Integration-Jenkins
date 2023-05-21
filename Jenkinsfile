pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        // Checkout the code from GitHub
        git 'https://github.com/your-username/your-repo.git'
      }
    }
    
    stage('Build and Push Docker Image') {
      steps {
        script {
          def commitHash = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          def tagName = "v${commitHash}"
          
          docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            def dockerImage = docker.build("vnathanw/image-push:${tagName}")
            dockerImage.push()
          }
          
          // Update the deployment.yaml file with the new image tag
          sh 'sed -i "s|image: vnathanw/image-push:.*$|image: vnathanw/image-push:${tagName}|" deployment.yaml'
          
          // Commit and push the updated deployment.yaml file
          withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
            sh 'git config user.name "Jenkins"'
            sh 'git config user.email "jenkins@example.com"'
            sh "git add deployment.yaml"
            sh 'git commit -m "Update deployment.yaml with image tag ${tagName}"'
            sh 'git push origin master'
          }
        }
      }
    }
  }
}
