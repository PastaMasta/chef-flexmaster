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
  'backup/local',
  'backup/remote',
  'docs',
  'repo',
  'repo/build',
  'repo/media',
  'repo/media/movies',
  'repo/media/music',
  'repo/media/picture',
  'repo/media/shows',
  'repo/mrepo',
  'repo/os',
  'users',
  'virt',
  'virt/storage'
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

# KVM
default['repo']['kvm']['storage'] = [

  { 'name' => 'virt',
    'path' => File.join(node['repo']['root'],'virt/storage')
  }

]
