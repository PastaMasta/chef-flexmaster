#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: fileserver
#
# Copyright 2017, PastaMasta
#

# Grab host options
backup_hosts  = node['repo']['chef-options']['backups']
desktop_hosts = node['repo']['chef-options']['desktops']
kvm_hosts = search(:node, 'recipes:"chef-base-dev\:\:kvm"').map {|a|a.name}

#
# nfs
#
service 'nfs-server' do
  action [ :enable, :start ]
end

template "/etc/exports" do
  source "etc/exports.erb"
  mode 0644
  notifies :restart, 'service[nfs-server]', :immediately
  variables ({
    :kvm_hosts => kvm_hosts,
    :desktop_hosts => desktop_hosts,
    :backup_hosts => backup_hosts
  })
end

#
# http
#
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
template "/etc/samba/smb.conf" do
  source "etc/samba/smb.conf.erb"
  mode 0644
  notifies :restart, 'service[smb]', :immediately
  variables ({
    :desktop_hosts => desktop_hosts,
    :backup_hosts => backup_hosts
  })
end

service 'smb' do
  action [ :enable, :start ]
end

#
# Permissions and SELinux
#

# ./docs/
docs_group = node['repo']['docs_group']
execute "chown docs" do
  command "chgrp #{docs_group} #{File.join(node['data']['root'],'docs')}"
  not_if "[[ $(stat --format=%G #{File.join(node['data']['root'],'docs')}) == #{docs_group} ]]"
end
directory File.join(node['data']['root'],'docs') do
   mode 0775
end

# ./backup/local
backup_group = node['repo']['backup_group']
execute "chown backups" do
  command "chgrp #{backup_group} #{File.join(node['data']['root'],'backup/local')}"
  not_if "[[ $(stat --format=%G #{File.join(node['data']['root'],'docs')}) == #{backup_group} ]]"
end
directory File.join(node['data']['root'],'backup/local') do
   mode 0775
end

# ./repo/
repo_user = node['repo']['repo_user']
execute "chown repo" do
  command "chown #{repo_user}:#{repo_user} #{File.join(node['data']['root'],'repo')}"
  not_if "[[ $(stat --format=%U:%G #{File.join(node['data']['root'],'repo')}) == '#{repo_user}:#{repo_user}' ]]"
end
