#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: fileserver
#
# Copyright 2017, PastaMasta
#

# nfs
package 'nfs-utils'

=begin
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
=end

# Http
package 'httpd'

link '/var/www/repo' do
  action :create
  to "#{node['data']['root']}/repo"
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
  source "httpd/repo.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]', :immediately
end

# SELinux
