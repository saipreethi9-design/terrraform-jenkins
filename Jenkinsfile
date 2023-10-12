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
                        googleCredentials = env.SERVICE_ACCOUNT_KEY_A
                    } else {
                        projectId = 'sixth-oxygen-400306'
                        googleCredentials = env.SERVICE_ACCOUNT_KEY_B
                    }

                    // Set the GOOGLE_CREDENTIALS environment variable
                    env.GOOGLE_CREDENTIALS = googleCredentials

                    // Set the GCP_PROJECT_ID environment variable
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
