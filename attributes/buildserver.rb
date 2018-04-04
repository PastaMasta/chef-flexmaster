#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Attribue:: buildserver
#
# Copyright 2018, PastaMasta
#

# Build server kickstarts
default['repo']['pxebuild']['git'] = 'https://github.com/PastaMasta/pxe-builds.git'

# tftp bootimages
default['repo']['bootimage_dirs'] = %w(
  diag
  installers
  installers/centos7-x86_64
  installers/centos6-x86_64
  other
)

default['repo']['bootimages'] = [
  { 'source' => "#{node['data']['root']}/repo/os/CentOS/6/os/x86_64/isolinux/memtest",
    'target' => 'diag/memtest' },

  { 'source' => "#{node['data']['root']}/repo/os/Other/dban.bzi",
    'target' => 'diag/dban.bzi' },

  { 'source' => "#{node['data']['root']}/repo/os/CentOS/6/os/x86_64/images/pxeboot/vmlinuz",
    'target' => 'installers/centos6-x86_64/vmlinuz' },

  { 'source' => "#{node['data']['root']}/repo/os/CentOS/6/os/x86_64/images/pxeboot/initrd.img",
    'target' => 'installers/centos6-x86_64/initrd.img' },

  { 'source' => "#{node['data']['root']}/repo/os/CentOS/7/os/x86_64/images/pxeboot/vmlinuz",
    'target' => 'installers/centos7-x86_64/vmlinuz' },

  { 'source' => "#{node['data']['root']}/repo/os/CentOS/7/os/x86_64/images/pxeboot/initrd.img",
    'target' => 'installers/centos7-x86_64/initrd.img' }
]
