#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Attribue:: default
#
# Copyright 2017, PastaMasta
#


# Layout basics
override['data']['root'] = '/data'
override['data']['layout'] = [
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
  'repo/os',
  'repo/os/isos',
  'repo/software',
  'users'
]
default['repo']['docs_user'] = 'sbt'
=begin

# User to own repo files
default['repo']['user'] = {
  'name' => 'repo',
  'uid' => 500,
  'gid' => 500
}


# tftp images
default['repo']['bootimages'] = [
  { 'source' => "#{node['repo']['root']}/repo/os/CentOS/6/os/x86_64/isolinux/memtest",
    'target' => '/var/lib/tftpboot/bootimages/diag/memtest' },

  { 'source' => "#{node['repo']['root']}/repo/os/CentOS/6/os/x86_64/images/pxeboot/vmlinuz",
    'target' => '/var/lib/tftpboot/bootimages/installers/centos6-x86_64/vmlinuz' },

  { 'source' => "#{node['repo']['root']}/repo/os/CentOS/6/os/x86_64/images/pxeboot/initrd.img",
    'target' => '/var/lib/tftpboot/bootimages/installers/centos6-x86_64/initrd.img' },

  { 'source' => "#{node['repo']['root']}/repo/os/CentOS/7/os/x86_64/images/pxeboot/vmlinuz",
    'target' => '/var/lib/tftpboot/bootimages/installers/centos7-x86_64/vmlinuz' },

  { 'source' => "#{node['repo']['root']}/repo/os/CentOS/7/os/x86_64/images/pxeboot/initrd.img",
    'target' => '/var/lib/tftpboot/bootimages/installers/centos7-x86_64/initrd.img' }
]

# KVM
default['repo']['kvm']['storage'] = [
  { 'name' => 'virt',
    'path' => File.join(node['repo']['root'],'virt/storage') }
]
=end
