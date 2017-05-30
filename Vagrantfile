# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.hostname="PUPPADEY.qac.local"
  config.vm.box = "chad-thompson/ubuntu-trusty64-gui"
  config.vm.network :public_network, ip: "192.168.1.17"
  
  config.vm.synced_folder "shared", "/tmp/shared"

  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
	 vb.name ="PUppadeyServer1"
     # Customize the amount of memory on the VM:
     vb.memory = "4096"
	 vb.cpus = 2
   end
   config.vm.provision :shell, path: "bootstrap.sh"
end
