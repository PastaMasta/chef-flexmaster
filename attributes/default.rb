#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: flexmaster
# Attribue:: default
#
# Copyright 2015, PastaMasta
#

# Main repo dir, everything in here will be public readable
default['repo']['dir'] = '/naspool/repo'

# User / group for the repo
default['repo']['user'] = 'repo'
default['repo']['uid'] = '1000'
default['repo']['group'] = 'repo'
default['repo']['gid'] = 'repo'

# Generic name of misc stuff
default['repo']['name'] = 'repo'

# tftpboot location for pxebooting
default['pxeboot']['tftpboot'] = '/var/tftpboot'

# NFS exports
default['nfs']['exports'] = [
  "#{node['repo']['dir']} *(sync,fsid=0)"
]

# Samba
default['samba']['workgroup'] = 'WORKGROUP'

# Samba shares
default['samba']['shares'] = [
  "#{node['repo']['name']}"
]

# buildserver dirs and symlinks
default['buildserver']['basedir'] = "#{default['repo']['dir']}/build"

default['buildserver']['dirs'] = [
  'chef'
]
default['buildserver']['symlinks'] = [
 {'target' => 'chef/client.rb', 'to' => '/etc/chef/client.rb' }, 
 {'target' => 'chef/initial.json', 'to' => '/etc/chef/initial.json' }, 
 {'target' => 'chef/validation.pem', 'to' => '/etc/chef/validation.pem' }
]
# Kickstart repo
default['buildserver']['kickstarts']['repo'] = "http://GitLab/chef/kickstarts.git"

# Misc packages
default['misc']['packages'] = [
  'createrepo'
]
