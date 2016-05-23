#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: fileshare
#
# Copyright 2015, PastaMasta
#

# nfs
package 'nfs-utils' do
  action :install
end

service 'nfs' do
  action [ :enable, :start ]
end

template "/etc/exports" do
  source "exports.erb"
  mode 0644
  notifies :restart, 'service[nfs]', :immediately
end

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

# Samba
package 'samba' do
  action :install
end

service 'smb' do
  action [ :enable, :start ]
end

template '/etc/samba/smb.conf' do
  source "smb.conf.erb"
  mode 0644
  notifies :restart, 'service[smb]', :immediately
end

template '/etc/samba/smbusers' do
  source "smbusers.erb"
  mode 0644
  notifies :restart, 'service[smb]', :immediately
end
