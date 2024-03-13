pipeline { 
     agent any
     stages { 
          stage("Compile") { 
               steps { 
                    sh "./gradlew compileJava" 
               } 
          } 
          stage("Unit test") { 
               steps { 
                    sh "./gradlew test" 
               } 
          }
          stage("Code Coverage") {
                steps {
                    sh "./gradlew jacocoTestReport"
                    sh "./gradlew jacocoTestCoverageVerification"
                }
          }
          stage("Package") {
            steps {
                sh "./gradlew build"
            }
          }
          stage("Docker build") {
            steps {
                sh "docker build -t dezin7/calculator:${BUILD_TIMESTAMP} ."
            }
          }
          stage("Docker push") {
            steps {
                sh "docker push  dezin7/calculator:${BUILD_TIMESTAMP}"
            }
          }

          stage("Update Version") {
            steps {
                sh "sed  -i 's/{{VERSION}}/${BUILD_TIMESTAMP}/g' deployment.yaml"
            } 
          }

          stage("Deploy to staging") {
            steps {
                    sh "sudo k3s kubectl config use-context staging-calculator"
                    sh "sudo k3s kubectl apply -f deployment.yaml"
                    sh "sudo k3s kubectl apply -f service.yaml"
            }
          }
          stage("Acceptance test") {
            steps {
                sleep 60
                sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
            }
          }
     }
     post {
        always {
            sh "docker stop calculator"
        }
     }
}