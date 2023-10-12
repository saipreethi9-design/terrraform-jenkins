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
                sh 'terraform plan'
            }
        }
        stage('Confirm Apply') {
            steps {
                script {
                    // Set the service account key as an environment variable
                    withCredentials([file(credentialsId: 'jenkins-poc-400711', variable: 'SA_KEY')]) {
                        
                        // Set the service account for this session
                        sh "gcloud auth activate-service-account --key-file=${SA_KEY}"
                        sh "gcloud config set project ${GCP_PROJECT_ID}"
                    }
                    input message: 'Proceed with apply? Please check Plan stdout carefully.', ok: 'Proceed'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                     withCredentials([file(credentialsId: 'jenkins-poc-400711', variable: 'SA_KEY')]) {
                        
                        // Set the service account for this session
                        sh "gcloud auth activate-service-account --key-file=${SA_KEY}"
                        sh "gcloud config set project ${GCP_PROJECT_ID}"
                    }
                    
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
