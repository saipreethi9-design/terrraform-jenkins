pipeline {
    agent any
    parameters {
        choice(
            name: 'TARGET_GCP_PROJECT',
            choices: [    
                'jenkins-poc-402417',
                'bold-catfish-402405'
            ]
        )
    } 
    environment {
        GCP_PROJECT_ID = "${params.TARGET_GCP_PROJECT}"
        GOOGLE_CREDENTIALS = credentials("${params.TARGET_GCP_PROJECT}")
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
                sh "terraform plan -var='project=${params.TARGET_GCP_PROJECT}'"
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    input message: "Proceed with apply? Please, check Plan stdout carefully.", ok: 'Proceed'
                    sh "terraform apply --auto-approve -var='project=${params.TARGET_GCP_PROJECT}'"
                }
            }
        }
    }

    post {
        always {
            sh 'rm -rf .terraform terraform.tfstate*'
        }
    }
}
