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
        parallel {
            stage('Board'){
                steps {
                    bat 'behave trello/api/features/Board.feature --tags=~@wip --tags=~@defect'
                    build(job: "Board Job")
                }
            }
            stage('Card'){
                steps {
                    bat 'behave trello/api/features/Card.feature --tags=~@wip --tags=~@defect'
                    build(job: "Board Job")
                }
            }
            stage('Checklist'){
                steps {
                    bat 'behave trello/api/features/Checklist.feature --tags=~@wip --tags=~@defect'
                    build(job: "Board Job")
                }
            }
            stage('List'){
                steps {
                    bat 'behave trello/api/features/List.feature --tags=~@wip --tags=~@defect'
                    build(job: "Board Job")
                }
            }
             stage('Organization'){
                steps {
                    bat 'behave trello/api/features/Organization.feature --tags=~@wip --tags=~@defect'
                    build(job: "Board Job")
                }
            }
        }
    }
    stage('REPORTS') {
      steps {
        bat 'behave -f allure_behave.formatter:AllureFormatter -o reports trello/api/features/ --tags=~@defect'
        bat 'allure serve reports'
      }
    }
  }
}
