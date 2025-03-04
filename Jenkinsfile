pipeline {
    agent any 
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/your-project.git' 
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install' 
            }
        }
        stage('Test') {
            steps {
                junit(path: 'target/surefire-reports/*.xml')
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker build -t my-image .' 
                sh 'docker push my-image:latest' 
            }
        }
    }
}
