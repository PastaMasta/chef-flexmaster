#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: firewall
#
# Copyright 2018, PastaMasta
#

service 'firewalld' do
  action :nothing
end

%w(
  http
  samba
  nfs
).each do |service|
  execute "firewall service: #{service}" do
    command "firewall-cmd --permanent --add-service=#{service} --zone=internal"
    not_if "firewall-cmd --list-services --zone=internal | grep #{service}"
    notifies :reload, 'service[firewalld]',:delayed
  end
end
