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

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    } 

} 
