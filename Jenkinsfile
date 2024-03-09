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
                sh "docker build -t dezin7/calculator ."
            }
          }
          stage("Docker push") {
            steps {
                sh "docker push  dezin7/calculator"
            }
          }
          stage("Deploy to staging") {
            steps {
                sh "docker run -d --rm -p 8765:2376 --name calculator dezin7/calculator"
            }
          }
          stage("Acceptance test") {
            steps {
                sleep 120
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