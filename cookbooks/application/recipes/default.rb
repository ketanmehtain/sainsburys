#
# Cookbook Name:: application
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file File.join(Chef::Config[:file_cache_path], node['go']['filename']) do
	source node['go']['url']
	owner 'root'
	mode  '0644'
end

bash "untar_golang" do
	cwd Chef::Config[:file_cache_path]
	code <<-EOH
		tar -xzf #{node['go']['filename']} -C #{node['go']['install_dir']}
	EOH
	action :run
end

ruby_block "insert_path" do
  block do
    file = Chef::Util::FileEdit.new("/root/.bashrc")
    file.insert_line_if_no_match("export PATH=$PATH:/usr/local/go/bin", "export PATH=$PATH:/usr/local/go/bin")
    file.write_file
  end
end

cookbook_file '/opt/app.go' do
  owner 'root'
  group 'root'
  mode  '0644'
  action :create
  source 'app.go'
end

cookbook_file '/opt/run.sh' do
  owner 'root'
  group 'root'
  action :create
  source 'run.sh'
  mode '0755'
end

execute 'app-run' do
  command 'cd /opt ;sh run.sh'
end

cookbook_file '/etc/init.d/app' do
  owner 'root'
  group 'root'
  action :create
  source 'app.initd'
  mode '0755'
end

execute 'app-init' do
  command 'chkconfig --add app'
end

service 'app' do
      supports :restart => true, :start => true, :stop => true, :reload => true
      action [ :enable, :start]
end
