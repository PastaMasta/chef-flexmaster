Master Cookbook
======================

A cookbook to setup my master / general utility server.
It is expected prior to running that the dir in ```default['repo']['dir']``` has been setup with the required storage mount.

## buildserver.rb
* Sets up kickstart dirs and clones kickstart files
* Sets up a pxeboot server with tftp via xinetd

## fileserver.rb
* Sets up NFS of the whole repo dir
* Sets up HTTP sharing of the repo
* Sets up Samba sharing of the repo

## misc.rb
* Sets up the CentOS mirror sync
* Installs createrepo

License and Authors
-------------------
Authors: PastaMasta
