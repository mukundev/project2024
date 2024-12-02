pipeline {
    agent any

 environment {
        DOCKER_IMAGE_NAME = "mukundhandocker/dev"
        DOCKER_REGISTRY = "docker.io"         
        DOCKER_COMPOSE_FILE = "docker-compose.yaml"
        DOCKER_COMPOSE_SERVICE = "react-app"
 }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from Git repository'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image'
                    sh 'docker build -t $DOCKER_IMAGE_NAME .'
                }
            }
        }

         stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        sh 'docker push $DOCKER_IMAGE_NAME'                    }
                }
            }
        }



        stage('Deploy with Docker Compose') {
            steps {
                script {
                    echo 'Deploying Docker containers using Docker Compose'
                    sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker images and containers'
            sh 'docker system prune -f'
        }
    }
}

