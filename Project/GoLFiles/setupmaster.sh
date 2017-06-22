#!/bin/bash
sudo add-apt-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible
ansible --version
#using python3 as we're using python3 interpreter for ansible
sudo apt install python3-pip
#boto is required for ansible
sudo pip install boto
sudo pip install --upgrade pip
sudo git clone https://github.com/pawnu/DevOps-Exercise-Book.git
sudo scp /home/ubuntu/DevOps-Exercise-Book/Project/* /etc/ansible
sudo chown -R ubuntu /home/ubuntu/.ansible
cd /etc/ansible/
#create localhost for installing docker and services in the master
cat<<EOT>> /etc/ansible/hosts
[hosts]
localhost ansible_connection=local
[webserver]
EOT 
#requires sudo to create and retry the yml file cause of boto errors
sudo ansible-playbook -i hosts jira.yml
#install java,git,maven to all agents
ansible-playbook -i hosts javamavengit.yml
#add the keypair used to access the slave machines to environment
exec ssh-agent bash
#ssh-add ~/.ssh/AWSJJSEPK.pem
# ansible-playbook -i '35.176.201.215, ' nexus.yml -e 'ansible_python_interpreter=/usr/bin/python3'
