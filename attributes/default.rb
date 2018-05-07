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

#
# Packages
#
# Build server
default['base']['packages'] << %w(
  tftp-server
  syslinux
)
# Fileserver
default['base']['packages'] << %w(
  nfs-utils
  httpd
  samba
)
# Misc
default['base']['packages'] << %w(
  createrepo
)

# Simple config options
default['repo']['chef-options']['dir'] = '/root/chef-options'

# Main users and groups
default['base']['users'] = {
  'repo' => { 'uid'=>2000,'home'=>'/data/repo','shell'=>'/sbin/nologin' }
}
default['base']['groups'] = {
  'docs' => { 'gid'=>3000,'members'=> %w(repo) },
  'backups' => { 'gid'=>3001,'members'=> %w(repo) }
}
default['repo']['repo_user'] = 'repo'
default['repo']['docs_group'] = 'docs'
default['repo']['backup_group'] = 'backups'

