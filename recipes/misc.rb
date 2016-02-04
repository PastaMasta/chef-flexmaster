#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: flexmaster
# Recipe:: misc
#
# Copyright 2015, PastaMasta
#

# yum repo sync scripts
template "/root/repo_sync.sh" do
  source "repo_sync.sh.erb"
  mode 0644
end
