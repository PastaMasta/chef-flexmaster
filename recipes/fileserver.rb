#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: fileserver
#
# Copyright 2017, PastaMasta
#

# nfs
package 'nfs-utils'

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
File.read('/root/repo/desktops').split("\n").each do |host|
  next if host == node['master']
  desktop_hosts.push("#{host}(sync,rw,sec=sys)")
end if File.exist?('/root/repo/desktops')

template "/etc/exports" do
  source "etc/exports.erb"
  mode 0644
  notifies :restart, 'service[nfs-server]', :immediately
  variables ({
    :kvm_hosts => kvm_hosts.join(" ").strip,
    :desktop_hosts => desktop_hosts.join(" ").strip
  })
end

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

# Samba
package 'samba'

service 'smb' do
  action [ :enable, :start ]
end

template "/etc/samba/smb.conf" do
  source "samba/smb.conf.erb"
  mode 0644
  notifies :restart, 'service[smb]', :immediately
end

# Permissions and SELinux
docs_user = node['repo']['docs_user']
execute "chown docs" do
  command "chown #{docs_user}:#{docs_user} #{File.join(node['data']['root'],'docs')}"
  not_if "[[ $(stat --format=%U:%G /data/docs) == '#{docs_user}:#{docs_user}'}' ]]"
end
