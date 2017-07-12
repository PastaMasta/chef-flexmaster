#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: default
#
# Copyright 2017, PastaMasta
#

return unless "#{node['platform']} #{node['platform_version']}".match(/centos 7/)

recipes = [
  'chef-base-dev::default',
  cookbook_name + '::fileserver',
  cookbook_name + '::firewall'
]

include_recipe(recipes)
