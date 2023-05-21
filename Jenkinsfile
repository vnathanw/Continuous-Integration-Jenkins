pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        // Checkout the code from GitHub
        git branch: 'main', url: 'https://github.com/vnathanw/Continuous-Deployment-ArgoCD.git'
      }
    }
    
    stage('Build and Push Docker Image') {
      steps {
        script {
                              def dockerImageTag = "${env.BUILD_NUMBER}" // Set a unique tag for the image, such as the build number
          
          docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            docker.build("vnathanw/image-push:${dockerImageTag}", "--build-arg HTML_FILE=index.html .")
            dockerImage("vnathanw/image-push:${dockerImageTag}).push()
          }
          
          // Update the deployment.yaml file with the new image tag
          sh 'sed -i "s|image: vnathanw/image-push:.*$|image: vnathanw/image-push:${dockerImageTag}|" deployment.yaml'
          
          // Commit and push the updated deployment.yaml file
          withCredentials([string(credentialsId: 'github', variable: 'GIT_TOKEN')]) {
            sh 'git config user.name "Nathan"'
            sh 'git config user.email "vnathanw@gmail.com"'
            sh 'git add deployment.yaml'
            sh 'git commit -m "Update deployment.yaml with image tag ${dockerImageTag}"'
            sh 'git push origin main'
          }
        }
      }
    }
  }
}
