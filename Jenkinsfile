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

       // stage('Authentication') {
       //      steps {
       //          script {
       //              def projectId
        
       //              if (params.TARGET_GCP_PROJECT == 'jenkins-poc-400711') {
       //                  projectId = 'jenkins-poc-400711'
       //              } else {
       //                  projectId = 'sixth-oxygen-400306'
       //              }
        
       //              // Load the service account JSON key from Jenkins credentials
       //              withCredentials([file(credentialsId: "${projectId}", variable: 'SERVICE_ACCOUNT_KEY_FILE')]) {
       //                  env.GOOGLE_CREDENTIALS = readFile("${SERVICE_ACCOUNT_KEY_FILE}")
       //              }
        
       //              // Set the GCP_PROJECT_ID environment variable
       //              env.GCP_PROJECT_ID = projectId
       //          }
       //      }
       //  }


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
