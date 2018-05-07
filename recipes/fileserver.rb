#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: fileserver
#
# Copyright 2017, PastaMasta
#

# nfs
service 'nfs-server' do
  action [ :enable, :start ]
end

# Only export to nodes running KVM
kvm_hosts = []
search(:node, 'recipes:"chef-base-dev\:\:kvm"').each do |host|
  next if host.name == node['master']
  kvm_hosts.push("#{host.name}(sync,rw,sec=sys)")
end

# Grab desktop hosts
desktop_hosts = []
node['repo']['chef-options']['desktops'].uniq.each do |host|
  next if host == node['master']
  desktop_hosts.push("#{host}(sync,rw,sec=sys)")
end

template "/etc/exports" do
  source "etc/exports.erb"
  mode 0644
  notifies :restart, 'service[nfs-server]', :immediately
  variables ({
    :kvm_hosts => kvm_hosts,
    :desktop_hosts => desktop_hosts
  })
end

# http
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
  source "etc/httpd/repo.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]', :immediately
end

# Samba

service 'smb' do
  action [ :enable, :start ]
end

template "/etc/samba/smb.conf" do
  source "etc/samba/smb.conf.erb"
  mode 0644
  notifies :restart, 'service[smb]', :immediately
end
