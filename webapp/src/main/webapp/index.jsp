pipeline {
    agent any
      environment {
          PATH= "/opt/maven/bin:$PATH"
       }
        stages{
              stage("Clone Code"){                 
                   steps{                     
                       git 'https://github.com/rahulchitransh/hello.git'
                     }
                 }
               stage("build Code"){
                   steps{                 
                    sh "mvn clean install"
                 }}
                stage("deploy"){
                   steps{                 
                    sshagent(['deploy_user']) {
                     sh "scp -o StrictHostKeyChecking=no webapp/target/webapp.war  ec2-user@34.238.255.152:/opt/tomcat/webapps"
      //scp <src file> username@ip:<dest path>
}
                 }  
               }
        }
    }
         
