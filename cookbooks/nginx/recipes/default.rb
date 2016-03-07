#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx" do
  action :install
end

template '/etc/nginx/conf.d/default.conf' do
	source 'default.conf.erb'
	owner  'root'
	group  'root'
	mode   '0644'
  notifies :reload, 'service[nginx]'
end

ruby_block "update_host_entry" do
  block do
    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.insert_line_if_no_match("172.28.128.4 app1", "172.28.128.4 app1")
    file.insert_line_if_no_match("172.28.128.5 app2", "172.28.128.5 app2")
    file.write_file
  end
end

service "nginx" do
  action [ :enable, :start ]
end