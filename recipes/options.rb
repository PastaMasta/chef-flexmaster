#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: options
#
# Copyright 2017, PastaMasta
#

# Deploys files and re-reads contents into node data for configuring the Chef
# run from files on disk
options_dir = node['repo']['chef-options']['dir']
directory options_dir

%w(
  backups
  desktops
).each do |file|

  filepath = File.join(options_dir,file)

  template filepath do
    source File.join('options',"#{file}.erb")
    action :create_if_missing
  end

  if File.exist?(filepath)
    node.default['repo']['chef-options'][file] = File.readlines(filepath).reject {|a| a.match(/^#/)}.map(&:strip)
  end

end
