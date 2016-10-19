#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Attribue:: default
#
# Copyright 2016, PastaMasta
#

# Layout basics
default['repo']['root'] = '/data'
default['repo']['layout'] = [
  'backup',
  'users',
  'repo/build',
  'repo/media',
  'repo/os',
  'virt'
]

# Fileserver
default['repo']['nfs'] = [
  "#{node['repo']['root']}/repo *(sync,fsid=0)",
  "#{node['repo']['root']}/users *(sync,fsid=0)"
]
