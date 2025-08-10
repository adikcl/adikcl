pipeline {
    agent any

    environment {
        REGISTRY = "quay.io/yourusername"       // Change to your container registry
        IMAGE_NAME = "myapp"                    // App name (same as deployment in OpenShift)
        TAG = "${BUILD_NUMBER}"                 // Unique build tag
        OPENSHIFT_URL = "https://openshift.example.com" // OpenShift API endpoint
        OPENSHIFT_PROJECT = "myproject"         // Your OpenShift project/namespace
    }

    triggers {
        githubPush() // Auto-trigger on push to GitHub
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/yourrepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $REGISTRY/$IMAGE_NAME:$TAG ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'quay-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh """
                    echo $PASS | docker login $REGISTRY -u $USER --password-stdin
                    docker push $REGISTRY/$IMAGE_NAME:$TAG
                    """
                }
            }
        }

        stage('Deploy to OpenShift') {
            steps {
                withCredentials([string(credentialsId: 'oc-token', variable: 'TOKEN')]) {
                    sh """
                    oc login $OPENSHIFT_URL --token=$TOKEN --insecure-skip-tls-verify
                    oc project $OPENSHIFT_PROJECT
                    oc set image deployment/$IMAGE_NAME $IMAGE_NAME=$REGISTRY/$IMAGE_NAME:$TAG
                    oc rollout status deployment/$IMAGE_NAME
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed! Check Jenkins logs."
        }
    }
}
