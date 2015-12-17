#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: flexmaster
# Recipe:: pxeboot
#
# Copyright 2015, PastaMasta
#

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
