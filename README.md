chef-master cookbook
======================

Sets up a general purpose central utility server that acts as a file / media server, build server and home share server.

## chef-master::layout

Sets up the general layout where `node['repo']['root']` is the mountpoint of the storage backend - ZFS btrfs, one big disk etc.

```
node['repo']['root']
│
├── backup
│   ├── local
│   └── remote
├── repo
│   ├── build
│   │   └── kickstarts
│   ├── media
│   │   ├── movies
│   │   ├── music
│   │   ├── picture
│   │   └── shows
│   ├── mrepo
│   └── os
├── users
└── virt
```
### Backup
- local - Backups of devices on the local lan
- remote - local mirrors of remote backups (Github repos etc)

### repo
Everything under repo is shared out on read only NFS and HTTP, if this server has a cname to 'repo' repo is the doccument root.
- build - kickstarts and support scripts for building VMs
- media - local media
- mrepo - local mirrors of OS repos for anything built localy
- os - misc os files, ISOs random software etc

### Users
- User homeshares, shared out over basic NFS

## chef-master::fileserver
- Shares out repo over http and sets up nfs exports

## chef-master::mrepo
- Sets up mrepo to mirror Centos 6

## chef-master::buildserver
- Sets up pxe / tftpboot for building new servers

Dependencies
-------------------

License and Authors
-------------------
Authors: PastaMasta  
See [LICENSE](LICENSE.md) for license rights and limitations (GNU GPLv3).
