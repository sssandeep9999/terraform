pipeline {
    agent any
    stages {
        stage('Print Message') {
            steps {
                echo 'Hello World'
                sh ''' terraform --version
                packer --version
                jenkins --version
                java --version'''
            }
        }
        stage('Git Checkout') {
            steps {
                sh 'rm -rf terraform'
                sh 'git clone https://github.com/sssandeep9999/terraform.git'
                sh 'pwd & ls -al'
            }
        }
        stage('Packer AMI Creaion & Deploy through terraform') {
            steps {
                dir('./terraform') {
                sh 'pwd & ls -al'
                sh './script.sh'
                }
            }
        }
        stage('Extract IP and Check Website') {
            steps {
                dir('./terraform/packer/terraform_infra') {
                    // Execute the command to extract the IP address and save it to a file
                    sh "tail -2 weboutput.txt | head -2 | awk 'match (\$0, /my_public_ip = .*/) { print substr (\$0, RSTART, RLENGTH) }' | awk '{print \$3}' | cut -d '\"' -f 2 > appip.txt"
                    
                    // Sleep for 60 seconds
                    sleep(time: 60, unit: 'SECONDS')
                    
                    // Use curl to check if the website is reachable using the extracted IP address
                    sh "curl -I \$(cat appip.txt)"
                    sh 'pwd & ls -al'
                }
            }
        }
        // stage('Terraform Destroy') {
        //     steps {
        //          dir('./terraform/packer/terraform_infra') {
        //             sh 'terraform destroy --auto-approve'
        //          }
        //     }
        // }
    }
}
