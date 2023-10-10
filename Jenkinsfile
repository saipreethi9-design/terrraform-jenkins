pipeline {
    agent any

    environment {
        TF_VAR_project_id = 'jenkins-poc-400711'
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
                    withCredentials([file(credentialsId: 'jenkins-poc-400711', variable: 'SA_KEY')]) {
                        // Now you can use $SA_KEY in your scripts
                        env.SA_KEY = credentials('jenkins-poc-400711')
                    }
                    input message: 'Proceed with apply? Please check Plan stdout carefully.', ok: 'Proceed'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        always {
            sh 'rm -rf .terraform terraform.tfstate*'
        }
    }
}
