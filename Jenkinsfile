pipeline {
	agent any
	stages {
		stage("CI - Integración Continua") {
			agent {
				docker {
					image "node:24"
					reuseNode true
				}
			}
			stages {
				stage('CI - Obtener versión de app') {
					steps {
						script {
							env.APP_SEMANTIC_VERSION = sh(
								script: 'npm pkg get version | tr -d \'"\'',
								returnStdout: true
							).trim()
							echo "La versión de mi aplicación es: ${env.APP_SEMANTIC_VERSION}"
						}
					}
				}
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
			}
		}
		stage("CD - Construir imagen") {
			steps {
				sh "docker build -t curso-devops-backend:latest ."
				sh "docker tag curso-devops-backend zeniusv/curso-devops-backend:${env.APP_SEMANTIC_VERSION}"
				sh "docker tag curso-devops-backend ghcr.io/gitthingsdan/curso-devops-backend:${env.APP_SEMANTIC_VERSION}"
			}
		}
		stage("CD - Distribuir imagen Docker Hub") {
			steps {
				script {
					docker.withRegistry("https://index.docker.io/v1/", "dh-credencial"){
						sh "docker push zeniusv/curso-devops-backend:${env.APP_SEMANTIC_VERSION}"
					}
				}
			}
		}
		stage("CD - Distribuir imagen GitHub") {
			steps {
				script {
					docker.withRegistry("https://ghcr.io", "gh-credencial"){
						sh "docker push ghcr.io/gitthingsdan/curso-devops-backend:${env.APP_SEMANTIC_VERSION}"
					}
				}
			}
		}
	}
}