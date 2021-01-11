pipeline {
  agent { label 'docker' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    ansiColor('css')
  }
  triggers {
    cron('0 0 * * *')
  }
  stages {
    stage('Build - Composer 1') {
      when {
        branch 'release/v1'
      }
      steps {
        sh "docker build -t computerminds/composer:v1 ."
      }
    }
    stage('Publish - Composer 1') {
      when {
        branch 'release/v1'
      }
      steps {
        withDockerRegistry([ credentialsId: "1679f2a2-5b25-4749-8f17-163fd0ec35af", url: "" ]) {
          sh "docker push computerminds/composer:v1"
        }
      }
    }
    stage('Build - Composer 2') {
      when {
        branch 'release/v2'
      }
      steps {
        sh "docker build -t computerminds/composer:v2 ."
      }
    }
    stage('Publish - Composer 2') {
      when {
        branch 'release/v2'
      }
      steps {
        withDockerRegistry([ credentialsId: "1679f2a2-5b25-4749-8f17-163fd0ec35af", url: "" ]) {
          sh "docker push computerminds/composer:v2"
        }
      }
    }
    stage('Build - Legacy') {
      when {
        branch 'master'
      }
      steps {
        sh "docker build -t computerminds/composer:latest ."
      }
    }
    stage('Publish - Legacy') {
      when {
        branch 'master'
      }
      steps {
        withDockerRegistry([ credentialsId: "1679f2a2-5b25-4749-8f17-163fd0ec35af", url: "" ]) {
          sh "docker push computerminds/composer:latest"
        }
      }
    }
  }
}
