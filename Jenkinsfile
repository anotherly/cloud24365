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
		dir('Cloud24365') {
			sh 'mvn clean package'
		}
            }
        }
        stage('Test') {
            steps {
                sh 'echo Running tests'
		dir('Cloud24365') {
			sh 'mvn test'
		}
            }
        }
        stage('Deploy') {
            steps {
                // 여기에 WAR 파일을 특정 위치로 이동하는 명령어 추가
                sh 'echo Deploying the build'
		dir('Cloud24365') {
			sh 'cp target/firstSamplePro-1.0.0.war /kwsong/'
			sh 'cd /kwsong && mv firstSamplePro-1.0.0.war Cloud24365.war'
		}
            }
        }
        // `user` 배포 단계
        stage('Deploy User') {
            steps {
                // `pipeline_admin` 프로젝트가 성공적으로 완료된 후에 `pipeline_user` 프로젝트를 트리거합니다.
                script {
                    build job: 'pipeline_user'
                }
            }
        }
    }
}
