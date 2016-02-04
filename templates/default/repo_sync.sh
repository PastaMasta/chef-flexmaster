#! /bin/bash

centos_remote='rsync://rsync.mirrorservice.org/mirror.centos.org/6*'
epel_remote='rsync://rsync.mirrorservice.org/dl.fedoraproject.org/pub/epel/6*/x86_64*'

centos_local='<%= node['repo']['dir'] %>/os/Linux/CentOS/'
epel_local='<%= node['repo']['dir'] %/os/Linux/Fedora/epel/'

# Sync CentOS base OS
rsync -aSPvm --include='6**/' --progress --safe-links --delete --exclude "**i386**" ${centos_remote} ${centos_local}

# Sync epel repo
rsync -azSPvm --include='6**/' --progress --safe-links --delete --exclude "**i386**" ${epel_remote} ${epel_local}
