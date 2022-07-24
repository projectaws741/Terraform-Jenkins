pipeline
{
    agent any
    tools {
    terraform 'terraform-11'
    }
    stages
    {
        stage('GIT-Checkout')
        {
            steps
            {
                git branch: 'main', url: 'https://github.com/projectaws741/Terraform-Jenkins.git'
            }
        }
        stage('INIT')
        {
            steps
            {
                sh 'terraform init'
            }
        }
        stage('Apply')
        {
            steps
            {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Destroy')
        {
            steps
            {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
