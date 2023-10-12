pipeline {
    agent any
    parameters {
        choice(
            name: 'TARGET_GCP_PROJECT',
            choices: [
                'jenkins-poc-400711',
                'sixth-oxygen-400306'
            ]
        )
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

       stage('Authentication') {
            steps {
                script {
                    def projectId
                    def googleCredentials
        
                    if (params.TARGET_GCP_PROJECT == 'jenkins-poc-400711') {
                        projectId = 'jenkins-poc-400711'
                        googleCredentials = credentials('jenkins-poc-400711')
                    } else {
                        projectId = 'sixth-oxygen-400306'
                        googleCredentials = credentials('sixth-oxygen-400306')
                    }
        
                    withCredentials([file(credentialsId: googleCredentials, variable: 'SERVICE_ACCOUNT_KEY_FILE')]) {
                        env.GOOGLE_CREDENTIALS = readFile("${SERVICE_ACCOUNT_KEY_FILE}")
                    }
        
                    env.GCP_PROJECT_ID = projectId
                }
            }
        }


        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }

    post {
        always {
            sh 'rm -rf .terraform terraform.tfstate*'
        }
    }
}
