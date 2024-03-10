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
                sh "docker run -d --rm -p 8765:8080 --name calculator dezin7/calculator"
            }
          }
          stage("Acceptance test") {
            steps {
                sleep 60
                sh """
                response=\$(curl -sk http://localhost:8765/sum\\\?a\\\=1\\\&b\\\=2)
                echo "Response: \$response"
                if [ "\$response" = "3" ]; then
                  echo "Test passed!"
                else
                  echo "Test failed!"
                fi
                """
            }
          }
     }
     post {
        always {
            sh "docker stop calculator"
        }
     }
}