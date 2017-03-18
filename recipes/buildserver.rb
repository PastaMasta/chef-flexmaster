#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: buildserver
#
# Copyright 2016, PastaMasta
#

# Grab kickstarts
git "#{node['repo']['root']}/repo/build/pxe-builds" do
  action :sync
  repository "https://github.com/PastaMasta/pxe-builds.git"
end

# Setup tftp / pxeboot
package 'tftp-server' do
  action :install
end

service 'tftp' do
  action :enable
end

# Setup pxe menus
directory '/var/lib/tftpboot/pxelinux.cfg' do
  action :create
end

[ 'default',
  'diag',
  'installers',
  'other'
].each do |menu|
  template "/var/lib/tftpboot/pxelinux.cfg/#{menu}" do
    source 'pxe/' + menu + '.erb'
    action :create
  end
end

# Setup pxe menu bootimages
package 'syslinux' do
  action :install
end

[ 'chain.c32',
  'mboot.c32',
  'memdisk',
  'menu.c32',
  'pxelinux.0'
].each do |file|
  remote_file File.join('/var/lib/tftpboot/',file) do
    source 'file://' + File.join('/usr/share/syslinux/',file)
    action :create
  end
end

# Setup image dirs
[ 'diag',
  'installers',
  'installers/centos6-x86_64',
  'other'
].each do |dir|
  directory File.join('/var/lib/tftpboot/bootimages/',dir) do
    recursive true
    action :create
  end
end

# Copy in images from mrepo if they exist (rsync may not have run yet)
node['repo']['bootimages'].each do |bootimage|
  remote_file bootimage['target'] do
    source 'file://' + bootimage['source']
    action :create
  end if File.readable?(bootimage['source'])
end
