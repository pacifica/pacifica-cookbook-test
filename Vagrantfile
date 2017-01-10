# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  config.vm.define 'esmaster' do |esmaster|
    esmaster.vm.network "private_network", ip: "192.168.33.19"
    esmaster.vm.provision 'chef_client' do |chef|
        chef.chef_server_url = "http://192.168.33.1:8889"
        chef.validation_key_path = 'test/fixtures/.chef/stickywicket.pem'
        chef.add_role 'pacifica_elasticsearch_master'
    end
  end
  (0..9).each do |es_index|
    config.vm.define "es#{es_index}" do |es|
      es.vm.network 'private_network', ip: "192.168.33.2#{es_index}"
      es.vm.provision 'chef_client' do |chef|
        chef.chef_server_url = "http://192.168.33.1:8889"
        chef.validation_key_path = 'test/fixtures/.chef/stickywicket.pem'
        chef.add_role 'pacifica_elasticsearch_slave'
      end
    end
  end
  config.vm.define "core" do |core|
    core.vm.network "forwarded_port", guest: 80, host: 8080
    core.vm.network "private_network", ip: "192.168.33.10"
    core.vm.provision 'chef_client' do |chef|
      chef.chef_server_url = "http://192.168.33.1:8889"
      chef.validation_key_path = 'test/fixtures/.chef/stickywicket.pem'
      chef.add_role 'pacifica_core'
    end
  end
  config.vm.define "db" do |db|
    db.vm.network "private_network", ip: "192.168.33.11"
    db.vm.provision 'chef_client' do |chef|
      chef.chef_server_url = "http://192.168.33.1:8889"
      chef.validation_key_path = 'test/fixtures/.chef/stickywicket.pem'
      chef.add_role 'db_server'
    end
  end
end
