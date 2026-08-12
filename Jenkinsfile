pipeline {
    agent none

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: '', description: 'Leave blank to use BUILD_NUMBER')
        choice(name: 'DEPLOY_ENV', choices: ['dev', 'staging', 'prod'], description: 'Select the deployment environment')
    }

    environment {
        IMAGE_NAME = 'vicky005/jenkins-flow'
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
    }

    stages {

        parallel {
            stage('Unit Tests') {
                agent {
                    docker {
                        image 'maven:3.9-eclipse-temurin-21'
                    }
                }
                steps {
                    sh 'mvn test'
                }
                post {
                    always {
                        junit 'target/surefire-reports/*.xml'
                    }
                }
            }

            stage('Lint') {
                agent {
                    docker {
                        image 'maven:3.9-eclipse-temurin-21'
                    }
                }
                steps {
                    sh 'mvn checkstyle:check'
                }
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.9-eclipse-temurin-21'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }

        // stage('Test') {
        //     agent {
        //         docker {
        //             image 'maven:3.9-eclipse-temurin-21'
        //         }
        //     }
        //     steps {
        //         sh 'mvn test'
        //     }
        //     post {
        //         always {
        //             junit 'target/surefire-reports/*.xml'
        //         }
        //     }
        // }

        // stage('Docker Build & Push') {
        //     agent any
        //     steps {
        //         script {
        //             def imageTag = params.IMAGE_TAG?.trim() ?: env.BUILD_NUMBER
        //             def img = docker.build("${IMAGE_NAME}:${imageTag}")
        //             docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
        //                 img.push()
        //                 img.push('latest')
        //             }
        //         }
        //     }
        // }
    }
}