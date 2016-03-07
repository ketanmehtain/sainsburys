# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("landrush")
  raise 'landrush plugin is required'
end

Vagrant.configure(2) do |config|
  config.landrush.enabled = true
  $tld = "example.com"
# Application server 1
  config.vm.define "app1" do |app1|
    app1.vm.box = "centos"
    app1.vm.hostname = "app1"
    app1.vm.network :private_network, ip: "172.28.128.4"
    app1.landrush.host 'app1.example.com', '172.28.128.4'
    
    app1.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://manage.chef.io/organizations/ketan"
      chef.validation_key_path = "ketan-validator.pem"
      chef.validation_client_name = "ketan-validator"
      chef.node_name = "app1"
      chef.add_recipe "application"
    end
 
  end

# Application server 2
  config.vm.define "app2" do |app2|
    app2.vm.box = "centos"
    app2.vm.hostname = "app2"
    app2.vm.network :private_network, ip: "172.28.128.5"
    app2.landrush.host 'app2.example.com', '172.28.128.5'

    app2.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://manage.chef.io/organizations/ketan"
      chef.validation_key_path = "ketan-validator.pem"
      chef.validation_client_name = "ketan-validator"
      chef.node_name = "app2"
      chef.add_recipe "application"
    end
  end

# Load Balancer
  config.vm.define "lb1" do |lb1|
    lb1.vm.box = "centos"
    lb1.vm.hostname = "lb1"
    lb1.vm.network "forwarded_port", guest: 80, host: 8080
    lb1.vm.network :private_network, ip: "172.28.128.6"
    lb1.landrush.host 'lb1.example.com', '172.28.128.6'

    lb1.vm.provision :chef_client do |chef|
      chef.chef_server_url = "https://manage.chef.io/organizations/ketan"
      chef.validation_key_path = "ketan-validator.pem"
      chef.validation_client_name = "ketan-validator"
      chef.node_name = "lb1"
      chef.add_recipe "nginx"
    end
  end
end
