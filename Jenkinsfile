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
        }
      }
    }
  }
}
