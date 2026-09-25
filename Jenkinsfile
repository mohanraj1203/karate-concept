pipeline {
    agent any

    tools {
        // Configure a JDK 21 tool named 'jdk21' in Jenkins global tools
        jdk 'jdk21'
    }

    options {
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build + Karate tests') {
            steps {
                // Boots SmartCart via @SpringBootTest and runs all 30 Karate scenarios
                sh 'chmod +x gradlew && ./gradlew test --info'
            }
        }
        stage('Archive reports') {
            steps {
                junit 'build/test-results/test/*.xml'
                archiveArtifacts artifacts: 'build/karate-reports/**', allowEmptyArchive: true
            }
        }
    }

    post {
        always {
            publishHTML(target: [
                reportDir: 'build/karate-reports',
                reportFiles: 'karate-summary.html',
                reportName: 'Karate Report'
            ])
        }
    }
}
