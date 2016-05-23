#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: buildserver
#
# Copyright 2015, PastaMasta
#

# Setup kickstarts
basedir = node['buildserver']['basedir']

directory basedir do
  action :create
  recursive true
end

node['buildserver']['dirs'].each do |dir|
  directory File.join(basedir,dir) do
    action :create
    recursive true
  end
end

node['buildserver']['symlinks'].each do |link|
  link File.join(basedir,link['target']) do
    to link['to']
  end
end

git File.join(basedir,'kickstarts') do
  repository node['buildserver']['kickstarts']['repo']
  action :sync
end

# Setup pxeboot

['xinetd','tftp-server'].each do |package|
  package package do
    action :install
  end
end

service 'xinetd' do
  action [ :enable, :start ]
end

directory node['pxeboot']['tftpboot'] do
  action :create
end

template "/etc/xinetd.d/tftp" do
  source "tftp.erb"
  owner 'root'
  group 'root'
  mode 0600
  notifies :reload, 'service[xinetd]', :immediately
end
