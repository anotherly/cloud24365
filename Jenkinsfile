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
			sh 'cp target/firstSamplePro-1.0.0.war /hivesystem/user_application/'
		}
            }
        }
        // `user` 배포 단계
        stage('Deploy User') {
            steps {
                // 스크립트 실행
                script {
                    sh '/hivesystem/sh/deploy_user.sh'
                }
            }
        }
    }
}
