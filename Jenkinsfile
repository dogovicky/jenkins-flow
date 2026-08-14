@Library('jenkins-shared-lib') _

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
                echo 'Building the application...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.9-eclipse-temurin-21'
                }
            }
            steps {
                echo 'Running Tests...'
                sh 'mvn test'
            }
        }

        stage('Docker Build & Push') {
            agent any
            steps {
                script { 
                    def imgTag = resolveImageTag(params.IMAGE_TAG, env.BUILD_NUMBER) 
                    dockerBuildPush("${IMAGE_NAME}", imgTag)
                }
            }
        }

        stage ('Deploy') {
            parallel {
                
                stage('Deploy to Dev') {
                    agent any
                    when { expression { params.DEPLOY_ENV == 'dev' } }
                    steps {
                        sh 'echo Deploying to Development environment...'
                        // Add your deployment commands for Development here
                    }
                }
                stage('Deploy to Prod') {
                    agent any
                    when { expression { params.DEPLOY_ENV == 'prod' } }
                    steps {
                        sh 'echo Deploying to Production environment...'
                        // Add your deployment commands for Production here
                    }
                }
            }
       }
    }
}


    //    stage('Verify') {
    //         parallel {
    //             stage('Unit Tests') {
    //                 agent {
    //                     docker {
    //                         image 'maven:3.9-eclipse-temurin-21'
    //                     }
    //                 }
    //                 steps {
    //                     echo 'Running Unit Tests...'
    //                     sh 'mvn test'
    //                 }
    //             }

    //             stage('Lint') {
    //                 agent {
    //                     docker {
    //                         image 'maven:3.9-eclipse-temurin-21'
    //                     }
    //                 }
    //                 steps {
    //                     echo 'Running Linting...'
    //                     sh 'mvn checkstyle:check'
    //                 }
    //             }
    //         }
    //    }