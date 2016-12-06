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

service 'nfs-server' do
  action [ :enable, :start ]
end

template "/etc/exports" do
  source "exports.erb"
  mode 0644
  notifies :restart, 'service[nfs-server]', :immediately
end

# Http
package 'httpd' do
  action :install
end

link '/var/www/repo' do
  action :create
  to "#{node['repo']['root']}/repo"
end

link '/var/www/html/repo' do
  action :create
  to "/var/www/repo"
end

file '/etc/httpd/conf.d/welcome.conf' do
  action :delete
end

service 'httpd' do
  action [ :enable, :start ]
end

template "/etc/httpd/conf.d/repo.conf" do
  source "repo.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]', :immediately
end
