pipeline {
    agent any
    tools {
        maven 'Maven3'
        jdk 'JDK17'
    }
    environment {
        DOCKER_IMAGE = "myacr.azurecr.io/resume-website:latest"
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/youruser/resume-website.git'
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Publish to Nexus') {
            steps {
                sh 'mvn deploy'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Push to ACR') {
            steps {
                sh 'az acr login --name myacr'
                sh 'docker push $DOCKER_IMAGE'
            }
        }
        stage('Deploy to AKS') {
            steps {
                sh 'kubectl apply -f k8s-deployment.yaml'
                sh 'kubectl apply -f k8s-service.yaml'
            }
        }
    }
}
