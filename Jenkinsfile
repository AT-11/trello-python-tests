pipeline {
  agent any
    triggers {
    pollSCM('* * * * *')
    }
  stages {
    stage('BUILD') {
        steps {
            bat 'pip3 install -r requirements.txt'
            bat 'pip install allure-behave'
        }
    }
    stage('TEST') {
        steps {
            bat 'pytest test'
            bat 'behave trello/api/features --tags=~@wip --tags=~@defect'
        }
    }
    stage('REPORTS') {
        steps {
            bat 'behave -f allure_behave.formatter:AllureFormatter -o reports trello/api/features/ --tags=~@defect'
        }
    }
  }
}
