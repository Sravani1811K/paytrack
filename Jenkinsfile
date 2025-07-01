pipeline {
    agent any
    tools {
        maven 'MavenV3'
    }
    environment {
        JAVA_HOME = tool 'JDK17'
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
        GIT_CRED_ID = '6dbc5fc0-87d0-43cb-b6aa-5e04332bfd29'
        DOCKER_CRED_ID = 'dockerhub-creds'
        DOCKER_IMAGE = 'sravani1811k/paytrack-app'
        DOCKER_BIN = '/usr/local/bin/docker'   // Correct Docker path on your Mac
    }
    stages {
        stage('Fetch Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Sravani1811K/paytrack.git',
                    credentialsId: '6dbc5fc0-87d0-43cb-b6aa-5e04332bfd29'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                   // sh "${DOCKER_BIN} build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                    sh "${DOCKER_BIN} build -t ${DOCKER_IMAGE}:latest ."

                }
            }
        }
        
        stage('Docker Push') {
    steps {
        withCredentials([usernamePassword(credentialsId: "${DOCKER_CRED_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh '''
                echo "$DOCKER_PASS" | /usr/local/bin/docker login -u "$DOCKER_USER" --password-stdin
                /usr/local/bin/docker push sravani1811k/paytrack-app:latest
            '''
        }
    }
}

stage('Deploy to Kubernetes') {
    steps {
        sh '/usr/local/bin/kubectl apply -f paytrack-deployment.yaml'
        sh '/usr/local/bin/kubectl apply -f paytrack-service.yaml'
    }
}
        

    }
}
