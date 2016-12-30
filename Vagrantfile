# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  config.vm.provision 'chef_client' do |chef|
    chef.chef_server_url = "http://192.168.33.1:8889"
    chef.validation_key_path = 'test/fixtures/.chef/stickywicket.pem'
    chef.add_recipe 'build-essential'
  end
  config.vm.define "web" do |web|
    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.network "private_network", ip: "192.168.33.10"
  end
  config.vm.define "db" do |db|
    db.vm.network "private_network", ip: "192.168.33.11"
  end
end
