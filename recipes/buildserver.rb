#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: buildserver
#
# Copyright 2016, PastaMasta
#

# Grab kickstarts
git "#{node['data']['root']}/repo/build/pxe-builds" do
  action :sync
  repository node['repo']['pxebuild']['git']
end

service 'tftp' do
  action :enable
end

# Setup pxe menus
directory '/var/lib/tftpboot/pxelinux.cfg' do
  action :create
end

# Create files under pxelinux.cfg/ for every template
# that would go in there.
cb = run_context.cookbook_collection[cookbook_name]
menus = cb.manifest['templates'].select {|a| a['path'].match(/pxelinux.cfg/)}.map {|b|b['name']}
menus = menus.select {|a|a.match(/.erb$/)}.map {|a|a.sub(/.erb$/,'')}

menus.each do |menu|
  template "/var/lib/tftpboot/pxelinux.cfg/#{menu}" do
    source 'pxelinux.cfg/' + menu + '.erb'
    action :create
  end
end

# Setup pxe menu bootimages
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

node['repo']['bootimage_dirs'].each do |dir|
  directory File.join('/var/lib/tftpboot/bootimages/',dir) do
    recursive true
    action :create
  end
end

# Copy in images from if they exist (rsync may not have run yet)
node['repo']['bootimages'].each do |bootimage|
  remote_file File.join('/var/lib/tftpboot/bootimages',bootimage['target']) do
    source 'file://' + bootimage['source']
    action :create
  end if File.readable?(bootimage['source'])
end
