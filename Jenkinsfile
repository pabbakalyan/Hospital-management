pipeline {
    agent any

    tools{
            jdk 'jdk17'
            nodejs 'node16'
    }
  
    environment{
        SCANNER_HOME= tool 'sonar-scanner'
    }

    stages {
        stage('git-checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/pabbakalyan/Hospital-management.git'
            }
        }

    stage('OWASP FS SCAN') {
            steps {
               dependencyCheck additionalArguments: '--scan ./', odcInstallation: 'DP'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs ."
            }
        }
        
        stage('SONARQUBE ANALYSIS') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh " $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Hospital-management -Dsonar.projectKey=Hospital-management "
                }
            }
        }
        
        
         stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
     

         stage('Docker Build') {
            steps {
               script{
                   withDockerRegistry(credentialsId: '9ea0c4b0-721f-4219-be62-48a976dbeec0') {
                    sh "docker build -t  hospital:latest -f docker/Dockerfile . "
                    sh "docker tag hospital:latest pabbakalyan/hospital:latest "
                 }
               }
            }
        }

        stage('Docker Push') {
            steps {
               script{
                   withDockerRegistry(credentialsId: '9ea0c4b0-721f-4219-be62-48a976dbeec0') {
                    sh "docker push  pabbakalyan/hospital:latest "
                 }
               }
            }
        }
        stage('trivy') {
            steps {
               sh " trivy pabbakalyan/hospital:latest"
            }
        }
		stage('Deploy to Docker') {
            steps {
               script{
                   withDockerRegistry(credentialsId: '9ea0c4b0-721f-4219-be62-48a976dbeec0') {
                    sh "docker run -d --name to-do-app -p 4000:4000 pabbakalyan/hospital:latest "
                 }
               }
            }
        }

    }
}
