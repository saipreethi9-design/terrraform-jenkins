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
        GCP_PROJECT_ID = 'jenkins-poc-400711'
    }

    tools {
        terraform 'Terraform'
    }

    stages {
        stage('Checkout') {
@@ -28,15 +21,17 @@ pipeline {
            steps {
                script {
                    def projectId

                    if (params.TARGET_GCP_PROJECT == 'jenkins-poc-400711') {
                        projectId = 'jenkins-poc-400711'
                        env.GOOGLE_CREDENTIALS = credentials('jenkins-poc-400711')
                    } else if (params.TARGET_GCP_PROJECT == 'sixth-oxygen-400306') {
                        projectId = 'sixth-oxygen-400306'
                        env.GOOGLE_CREDENTIALS = credentials('sixth-oxygen-400306')
                    } else {
                        error("Invalid TARGET_GCP_PROJECT parameter value")
                        projectId = 'sixth-oxygen-400306'
                    }

                    // Set the GOOGLE_CREDENTIALS environment variable
                    env.GOOGLE_CREDENTIALS = credentials("${projectId}")

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

        /*stage('Confirm Apply') {
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
        }*/

        stage('Terraform Apply') {
            steps {
                script {
                    env.GCP_PROJECT_ID = projectId
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
