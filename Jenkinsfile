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
                    input message: 'Proceed with apply? Please check Plan stdout carefully.', ok: 'Proceed'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Confirm Destroy') {
            steps {
                script {
                    input message: 'Proceed with destroy? This will permanently delete resources.', ok: 'Destroy'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        always {
            sh 'rm -rf .terraform terraform.tfstate*'
        }
    }
}
