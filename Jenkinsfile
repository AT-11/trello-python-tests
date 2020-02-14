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
        stage('API TEST') {
            parallel {
                stage('Trello') {
                    steps {
                            bat 'behave -f allure_behave.formatter:AllureFormatter -o reportsTrello trello/api/features/ --tags=~@defect'
                    }
                }
                stage('Pivotal Tracker') {
                    steps {
                            bat 'behave -f allure_behave.formatter:AllureFormatter -o reportsPivotal pivotal/api/features/ --tags=~@defect'
                    }
                }
            }
        }
         stage('reports') {
            steps {
				script {
                    allure includeProperties: false, jdk: 'java11', results: [[path: 'reportsTrello']]
                    allure includeProperties: false, jdk: 'java11', results: [[path: 'reportsPivotal']]
				}
            }
        }
    }
}
