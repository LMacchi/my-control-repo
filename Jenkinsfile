def docker_image = 'ruby:2.4.3'

pipeline {
  agent {
    docker docker_image
  }
  stages {
    stage ('Run Tests') {
      steps {
        sh 'bundle install'
        sh 'bundle exec onceover run spec'
      }
    }
  }
}
