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
        stage('UNIT TEST') {
            steps {
                bat 'pytest test'
            }
        }
        stage('TEST') {
            parallel {
                stage('Trello') {
                    steps {
                            bat 'behave -f allure_behave.formatter:AllureFormatter
                            -o reports trello/api/features/ --tags=~@defect'
                    }
                }
                stage('Pivotal') {
                    steps {
                            bat 'behave -f allure_behave.formatter:AllureFormatter
                                 -o reports pivotal/api/features/ --tags=~@defect'
                    }
                }
            }
        }
  }
}