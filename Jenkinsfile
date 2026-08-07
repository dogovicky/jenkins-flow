pipeline {
    agent {
        docker {
            image 'maven:3.9-eclipse-temurin-21'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTestsclean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
    }
}