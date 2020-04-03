# movie-analyst-infra

        terraform init
        terraform plan -var-file="variables.tfvars" -auto-approve
        terraform apply -var-file="variables.tfvars" -auto-approve
        terraform destroy -var-file="variables.tfvars" -auto-approve