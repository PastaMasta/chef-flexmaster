#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: flexmaster
# Recipe:: default
#
# Copyright 2015, PastaMasta
#

user node['repo']['user'] do
  action :create
end

include_recipe [
  'chef-flexmaster::fileshare',
  'chef-flexmaster::pxeboot',
  'chef-flexmaster::buildserver',
]