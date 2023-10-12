pipeline {
    agent any

    environment {
         GCP_PROJECT_ID = 'jenkins-poc-400711'
    }

    tools {
        terraform 'Terraform'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Confirm Apply') {
            steps {
                script {
                    // Set the service account key as an environment variable
                    withCredentials([file(credentialsId: 'jenkins-poc-400711', variable: 'GC_KEY')]) {
                        sh "gcloud auth activate-service-account --key-file=${GC_KEY}"
                        sh "gcloud config set project ${GCP_PROJECT_ID}"
                    }
                    input message: 'Proceed with apply? Please check Plan stdout carefully.', ok: 'Proceed'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            sh 'rm -rf .terraform terraform.tfstate*'
        }
    }
}
