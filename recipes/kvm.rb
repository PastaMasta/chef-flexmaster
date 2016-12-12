#
# Author:: PastaMasta (<pasta.masta2902@gmail.com>)
# Cookbook Name:: chef-master
# Recipe:: kvm
#
# Copyright 2016, PastaMasta
#

# Install KVM and setup storage repo
packages = [
  'kvm',
  'libvirt',
  'virt-install',
  'qemu-kvm',
  'bridge-utils',
  'virt-manager'
]

packages.each do |pkg|
  package pkg do
    action :install
  end
end

service 'libvirtd' do
  action [ :enable, :start]
end


node['repo']['kvm']['storage'].each do |pool|

  execute 'libvirt pool' do
    command "/usr/bin/virsh --quiet pool-define-as #{pool['name']} dir --target #{pool['path']}"
    not_if "/usr/bin/virsh pool-info #{pool['name']}"
  end
  execute 'autostart pool' do
    command "/usr/bin/virsh --quiet pool-autostart #{pool['name']}"
    not_if "/usr/bin/virsh pool-info #{pool['name']} | grep -E 'Autostart:\s*yes' "
  end

end
