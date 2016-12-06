#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: default
#
# Copyright 2016, PastaMasta
#

recipes = [
  'chef-master::layout',
  'chef-master::fileserver',
  'chef-master::buildserver',
  'chef-master::kvm'
]

include_recipe(recipes)
