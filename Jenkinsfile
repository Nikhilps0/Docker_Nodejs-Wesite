pipeline{
  agent any

  environment{
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-cred')
    REMOTE_SERVER = '65.0.133.249'
    REMOTE_USER = 'ubuntu'
  }

  stages {
    stage('checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/palakbhawsar98/JavaWebApp'

      }
    }
   // Build docker image in Jenkins
    stage('Build Docker Image') {

      steps {
        sh 'docker build -t nodejswebsite:latest .'
        sh 'docker tag nodejswebsite nova69/nodejswebsite:latest'
      }
    }  
   // Login to DockerHub before pushing docker Image
    stage('Login to DockerHub') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u    $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }


   // Push image to DockerHub registry

    stage('Push Image to dockerHUb') {
      steps {
        sh 'docker push nova69/nodejswebsite:latest'
      }
      post {
        always {
          sh 'docker logout'
        }
      }

    }

   // Pull docker image from DockerHub and run in EC2 instance 

    stage('Deploy Docker image to AWS instance') {
      steps {
        script {
          sshagent(credentials: ['awscred']) {
          sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} 'docker stop nodejswebsite || true && docker rm nodejswebsite || true'"
      sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} 'docker pull nova69/nodejswebsite'"
          sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} 'docker run --name nodejswebsite -d -p 80:3000 nova69/nodejswebsite:latest'"
          }
        }
      }
    }
  }
}


