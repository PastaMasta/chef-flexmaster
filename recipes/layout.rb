#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: layout
#
# Copyright 2016, PastaMasta
#

node['repo']['layout'].each do |dir|

  directory = File.join(node['repo']['root'],dir)
  directory directory do
    action :create
    recursive true
  end

end
