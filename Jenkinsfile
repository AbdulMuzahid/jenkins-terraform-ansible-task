pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws') // ID from Jenkins credentials store
        AWS_SECRET_ACCESS_KEY = credentials('aws') // ID from Jenkins credentials store
     }
    stages {
        

        stage('Checkout') {
            steps {
                deleteDir()
                sh 'echo cloning repo'
                sh 'git clone https://github.com/AbdulMuzahid/jenkins-terraform-ansible-task.git' 
            }
        }
        
        stage('Terraform Apply') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/ansible-tf/jenkins-terraform-ansible-task/') {
                    sh 'pwd'
                    sh 'terraform init'
                    sh 'terraform plan'
                    // sh 'terraform destroy -auto-approve'
                    sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
        
        stage('Ansible Deployment') {
            steps {
                script {
                   sleep '160'
                    ansiblePlaybook becomeUser: 'ec2-user', credentialsId: 'amazon-linux', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/ansible-tf/ansible-task/inventory.yaml', playbook: '/var/lib/jenkins/workspace/ansible-tf/ansible-task/amazon-playbook.yml', vaultTmpPath: ''
                    ansiblePlaybook become: true, credentialsId: 'ubuntu', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/ansible-tf/jenkins-terraform-ansible-task/inventory.yaml', playbook: '/var/lib/jenkins/workspace/ansible-tf/jenkins-terraform-ansible-task/ubuntu-playbook.yml', vaultTmpPath: ''
                }
            }
        }
    }
}
