#! /bin/bash
function install_aws_cli() {
    echo UPDATING:
    apt-get update && echo "Successful update" || echo "Fail"
    echo INSTALLING AWSCLI:
    apt-get install awscli -y && echo "Succesful aws" || echo "Fail"
}

function download_files() {
    echo DOWNLOAD BUCKET:
    sudo aws s3 cp s3://${bucket_name} /tmp --recursive
}

function install_ansible() {
    sudo apt update
    sudo apt install software-properties-common -y
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible -y
}

function download_galaxy_roles() {
    echo DOWNLOAD ANSIBLE GALAXY ROLES:
    sudo mv /tmp/ansible/* /etc/ansible/
    sudo ansible-galaxy install -r /etc/ansible/requirements.yml --roles-path /etc/ansible/roles/
}

function run_ansible_playbook() {
    sudo ansible-playbook -i /etc/ansible/hosts /etc/ansible/deploy_jenkins.yml
}

function main() {
    install_aws_cli
    download_files
    install_ansible
    download_galaxy_roles
    run_ansible_playbook
}

main
