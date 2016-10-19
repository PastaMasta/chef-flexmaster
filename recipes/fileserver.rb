#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: fileserver
#
# Copyright 2016, PastaMasta
#

# nfs
package 'nfs-utils' do
  action :install
end

service 'rpcbind' do
  action [ :enable, :start ]
end

service 'nfs' do
  action [ :enable, :start ]
end

template "/etc/exports" do
  source "exports.erb"
  mode 0644
  notifies :restart, 'service[nfs]', :immediately
end

=begin
# http
package 'httpd' do
  action :install
end

service 'httpd' do
  action [ :enable, :start ]
end

template "/etc/httpd/conf.d/#{node['repo']['name']}.conf" do
  source "httpd.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]', :immediately
end
=end
