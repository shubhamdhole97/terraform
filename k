pipeline {
    agent any

    stages {
        stage('01.Clone Repo') {
            steps {
                echo "Git Cloning"
                git url: 'https://github.com/shubhamdhole97/msexcel.git', branch: 'main'
            }
        }
        stage('02.Clean') {
            steps {
                echo "Cleaning"
                sh 'mvn clean'
            }
        }
        stage('03.Package') {
            steps {
                echo "Packaging"
                sh 'mvn package'
            }
        }
        stage('04.Deploy to Nexus') {
            steps {
                echo "Deploy to Nexus"
                sh 'curl -v -u admin:123 --upload-file target/msexcel-0.0.1-SNAPSHOT.jar http://localhost:8081/repository/shubham/com/msoffice/msexcel/0.0.1/msexcel-0.0.1-SNAPSHOT.jar'
            }
        }
    }

    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}

pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // Specify your desired region
        GITHUB_REPO = 'https://github.com/shubhamdhole97/terraform.git'  // GitHub repository URL
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                // Clone the repository containing Terraform configuration (main.tf)
                git url: "${GITHUB_REPO}", branch: 'main'  // Replace with the desired branch if different
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '123']]) {
                    script {
                        // Run Terraform apply to create the S3 bucket
                        def applyCmd = 'terraform apply -auto-approve'
                        def result = sh(script: applyCmd, returnStdout: true).trim()

                        // Output the result of the apply command
                        echo "Terraform apply result: ${result}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'S3 bucket creation was successful!'
        }
        failure {
            echo 'S3 bucket creation failed.'
        }
    }
}
