#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Attribue:: default
#
# Copyright 2016, PastaMasta
#

default['repo']['root'] = '/data'
default['repo']['layout'] = [
  'backup',
  'repo/build',
  'repo/media',
  'repo/os',
  'virt'
]
