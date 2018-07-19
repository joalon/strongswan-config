# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.gui = true
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.galaxy_role_file = "provisioning/requirements.yml"
    ansible.compatibility_mode = "2.0"
    ansible.groups = {
	"vpn" => ["vpn.joalon.se"],
	"dns" => ["dns.joalon.se"],
	"yum" => ["yum.joalon.se"],
	"dhcp" => ["dhcp.joalon.se"]

    }
  end


  config.vm.define "gw" do |gw|
	gw.vm.hostname = "vpn.joalon.se"
	gw.vm.network :private_network, ip: "192.168.200.102"
  end

  config.vm.define "dns" do |dns|
	dns.vm.hostname = "dns.joalon.se"
	dns.vm.network :private_network, ip: "192.168.200.103"
  end

  config.vm.define "dhcp" do |dhcp|
	dhcp.vm.hostname = "dhcp.joalon.se"
	dhcp.vm.network :private_network, ip: "192.168.200.101"
  end

  config.vm.define "yum" do |yum|
	yum.vm.hostname = "yum.joalon.se"
	yum.vm.network :private_network, ip: "192.168.200.104"
	#yum.vm.synced_folder "/mnt/d/repos", "/mnt/repo"
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
