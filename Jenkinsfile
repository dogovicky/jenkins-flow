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

    triggers {
        githubPush()
    }

    stages {

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

        stage('Test') {
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

       stage('Verify') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        echo 'Running Unit Tests...'
                    }
                }

                stage('Lint') {
                    steps {
                        echo 'Running Linting...'
                    }
                }
            }
       }

       stage ('Deploy') {
            when { branch 'main'}
            parallel {
                stage('Deploy to Dev') {
                    when { expression { params.DEPLOY_ENV == 'dev' } }
                    steps {
                        sh 'echo Deploying to Development environment...'
                        // Add your deployment commands for Development here
                    }
                }
                stage('Deploy to Prod') {
                    when { expression { params.DEPLOY_ENV == 'prod' } }
                    steps {
                        sh 'echo Deploying to Production environment...'
                        // Add your deployment commands for Production here
                    }
                }
            }
       }

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