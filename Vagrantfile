# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbooks/apache.yml"
  end




  config.vm.define "ipsec-gw" do |gw|


  end


  config.vm.define "dns" do |dns|


  end

  config.vm.define "dhcp" do |dhcp|


  end



  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.network "public_network"

  # config.vm.synced_folder "../data", "/vagrant_data"

#  config.vm.provision "shell", inline: <<-SHELL
#    yum update -y
#    yum install -y epel-release
#    yum install -y nginx
#    systemctl enable nginx
#    systemctl start nginx
#  SHELL
end
