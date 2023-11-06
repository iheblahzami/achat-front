pipeline{
    agent any

stages{

    stage('pulling the code'){
        steps{
        git branch: 'main',
        url: 'https://github.com/iheblahzami/achat-front.git'
}}
    stage('docker'){
        steps{
                sh 'docker build . -t iheb49/achat-front:lts'
}}
        stage('Push Docker Image to Docker Hub') {
            steps {
               script {
           withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
               sh 'docker login -u iheb49 -p ${dockerhubpwd}'}

               sh 'docker push iheb49/achat-front:lts'
            }
            }
        }

}}
