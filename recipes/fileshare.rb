#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: flexmaster
# Recipe:: fileshare
#
# Copyright 2015, PastaMasta
#

# nfs
['nfs-utils','portmap'].each do |package|
  package package do
    action :install
  end
end

template "/etc/exports" do
  source "exports.erb"
  mode 0644
  notifies :restart, 'service[nfs]', :immediately
end

['nfs'].each do |service|
  service service do
    action [ :enable, :start ]
  end
end

# http
package 'httpd' do
  action :install
end

template "/etc/httpd/conf.d/#{node['repo']['name']}.conf" do
  source "httpd.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]', :immediately
end

service 'httpd' do
  action [ :enable, :start ]
end

# Samba
package 'samba' do
  action :install
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

service 'smb' do
  action [ :enable, :start ]
end
