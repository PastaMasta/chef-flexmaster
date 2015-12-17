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
default['repo']['group'] = 'repo'

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
