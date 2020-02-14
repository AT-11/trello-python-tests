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
                           echo 'trello'
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
						allure([
								includeProperties: true,
								jdk: 'java11',
								properties: [],
								reportBuildPolicy: 'ALWAYS',
								results: [[path: 'reportsPivotal']]
						])
				}
            }
        }
    }
}
