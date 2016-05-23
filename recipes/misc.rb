#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: misc
#
# Copyright 2015, PastaMasta
#

misc = node['misc']

# yum repo sync and update scripts
template "/root/repo_sync.sh" do
  source "repo_sync.sh.erb"
  mode 0744
end

template "/root/update-repo.sh" do
  source "update-repo.sh.erb"
  mode 0744
end

# Every other package
misc['packages'].each do |package|
  package package do
    action :install
  end
end
