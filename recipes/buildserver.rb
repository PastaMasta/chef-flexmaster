#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: flexmaster
# Recipe:: buildserver
#
# Copyright 2015, PastaMasta
#

basedir = node['buildserver']['basedir']

directory basedir do
  action :create
end

node['buildserver']['dirs'].each do |dir|
  directory File.join(basedir,dir) do
    action :create
  end
end

node['buildserver']['symlinks'].each do |link|
  link File.join(basedir,link['target']) do
    to link['to']
  end
end

git File.join(basedir,'kickstarts') do
  repository node['buildserver']['kickstarts']['repo']
  action :sync
end
