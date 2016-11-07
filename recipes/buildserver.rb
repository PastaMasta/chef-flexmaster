#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: buildserver
#
# Copyright 2016, PastaMasta
#

# Grab kickstarts
git "#{node['repo']['root']}/repo/build/kickstarts" do
  action :sync
  repository "https://github.com/PastaMasta/kickstarts.git"
end

# Setup tftp / pxeboot
