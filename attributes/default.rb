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
  'repo/mrepo',
  'repo/os',
  'virt'
]

# Fileserver
default['repo']['nfs'] = [
  "#{node['repo']['root']}/repo *(sync,ro)",
  "#{node['repo']['root']}/users *(sync,rw)"
]

# Mrepo
default['repo']['mrepo'] = {
  'srcdir' => "#{node['repo']['root']}/repo/mrepo"
}
