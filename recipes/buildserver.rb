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
