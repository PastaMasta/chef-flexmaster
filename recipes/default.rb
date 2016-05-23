#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: default
#
# Copyright 2015, PastaMasta
#

user node['repo']['user'] do
  action :create
  uid node['repo']['uid']
  gid node['repo']['gid']
end

include_recipe [
  'chef-master::fileserver',
  'chef-master::buildserver',
  'chef-master::misc'
]
