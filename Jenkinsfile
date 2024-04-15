pipeline {
    agent any

    tools {
        maven 'Maven' 
    }
   stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'echo Running build'
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'echo Running tests'
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                // 여기에 WAR 파일을 특정 위치로 이동하는 명령어 추가
                sh 'echo Deploying the build'
		            sh 'cp target/Cloud24365-0.war /kwsong/'
	              // 이름을 동일하게 바꿔주는 작업, sh는 독립된 환경에서 실행한다. 즉 이동한 경로에서 파일을 바꿔주고 싶다면 &&을 함께 써야 된다.
                // sh 'cd /kwsong && mv Cloud24365*.war Cloud24365.war'
            }
        }
        // `user` 배포 단계
        stage('Deploy User') {
            steps {
                // `pipeline_admin` 프로젝트가 성공적으로 완료된 후에 `pipeline_user` 프로젝트를 트리거합니다.
                script {
                    build job: 'pipeline_user', wait: true
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            junit 'target/surefire-reports/*.xml'
        }
        success {
            sh 'echo Build succeeded!'
        }
        failure {
            sh 'echo Build failed!'
        }
    }
}
