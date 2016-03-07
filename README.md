# Sainsburys
Repository for Sainsbury's 


This project demonstrates how to setup a simple multi-vm environment in Vagrant consisting of:

* One Nginx server which will act as load balancer (Round-Robin).
* Two Golang Application servers.

## <a name="requirements"></a> Requirements

### <a name="requirements-platform"></a> Platform

* CentOS-6.5

### <a name="requirements-tools"></a> Tools

This requires Vagrant, Chef (Managed), and Virtualbox to be installed.

Create an account on https://manage.chef.io/login.
Download the Validator key, Client key and knife.rb.
Upload the cookbooks to managed chef

```
knife cookbook upload -a
```

OR

Use the keys which are provided (but you cannot spin more than 5 instance).

Please make sure following Vagrant plugins installed.
 1. landrush
 
Run the below commands.

```
$ git clone https://github.com/ketanmehtain/sainsburys.git
$ vagrant box add centos https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box
$ vagrant up
```
Once all the vagrant box are created and provision is over update your /etc/hosts with below entry.
* 172.28.128.6 lb1.example.com lb1

Now hit this url on your browser :  http://lb1.example.com

## <a name="testing"></a> Testing

This project have [serverspec](http://serverspec.org) for syntax checking and
[test-kitchen](https://github.com/opscode/test-kitchen) for integration testing. You can run the test suite by
typing: `bundle exec kitchen test` (may be slow for the first time).

Please email me on ketanmehta.in@gmail.com 

