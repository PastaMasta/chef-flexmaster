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
  'repo/media/pictures',
  'repo/media/memories',
  'repo/media/shows',
  'repo/os',
  'repo/os/isos',
  'repo/software',
  'users'
]


default['base']['users'] = {
  'repo' => { 'uid'=>2000,'home'=>'/data/repo','shell'=>'/sbin/nologin' }
}
default['base']['groups'] = {
  'docs' => { 'gid'=>3000,'members'=> [] }
}

default['repo']['repo_user'] = 'repo'
default['repo']['docs_user'] = 'sbt'

default['repo']['chef-options']['dir'] = '/root/chef-options'
