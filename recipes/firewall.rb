#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: firewall
#
# Copyright 2017, PastaMasta
#

template '/etc/firewalld/zones/master-internal.xml' do
  action :create
  source 'firewalld/master-internal.xml.erb'
  notifies :reload, 'service[firewalld]',:immediately
end
