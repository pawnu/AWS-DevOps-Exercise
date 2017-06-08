sudo add-apt-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible
ansible --version
ssh-keygen -t rsa
ssh-agent bash
ssh-add ~/.ssh/id_rsa
ssh-copy-id vagrant@192.168.1.104
ansible all -i hosts -u vagrant -m setup
ansible all -m ping