#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: mrepo
#
# Copyright 2016, PastaMasta
#

# Installify
packages = [
  'mrepo',
  'rsync',
  'hardlink',
  'createrepo'
]

packages.each do |pkg|
  package pkg do
    action :install
  end
end

template '/etc/mrepo.conf' do
  action :create
  source 'mrepo.conf.erb'
end

template '/etc/mrepo.conf.d/centos.conf' do
  action :create
  source 'mrepo.conf.d.centos.erb'
end

template '/etc/mrepo.rsync.include' do
  action :create
  source 'mrepo.rsync.include.erb'
end

template '/etc/cron.d/mrepo' do
  action :create
  source 'mrepo.cron.erb'
end
