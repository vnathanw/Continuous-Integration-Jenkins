pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from Git
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                // Build and push the Docker image
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        def dockerImage = docker.build("vnathanw/image-push:v1")
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
