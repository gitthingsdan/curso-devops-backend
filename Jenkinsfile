pipeline {
	agent {
		docker {
			image "node:24"
			reuseNode true
		}
	}

	stages {
		stage('CI - Instalar dependencias') {
			steps {
				sh "npm install"
			}
		}
		stage('CI - Ejecutar el linter') {
			steps {
				sh "npm run lint"
			}
		}
		stage('CI - Ejecutar los tests') {
			steps {
				sh "npm run test"
			}
		}
		stage('CI - Construir o build') {
			steps {
				sh "npm run build"
			}
		}
		stage('CD - Construir imagen Docker') {
			steps {
				sh "docker build -t curso-devops-backend:latest ."
			}
		}
	}
}