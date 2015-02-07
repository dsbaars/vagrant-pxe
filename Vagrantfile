# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "puphpet/ubuntu1404-x64"
    config.vm.hostname = "pxeserver"
    config.vm.network "public_network"

    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", 4096]
        vb.customize ["modifyvm", :id, "--cpus", 2]
    end

    config.vm.provider "parallels" do |prl|
        prl.optimize_power_consumption = false
        prl.memory = 4096
        prl.cpus =  2
    end

    config.vm.synced_folder "pxe", "/pxe", type: "nfs"
    config.librarian_puppet.puppetfile_dir = "puppet"

    config.vm.provision "puppet" do |puppet|
        puppet.module_path = "puppet/modules"
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'site.pp'
        puppet.options = "--verbose --debug --trace"
    end
end
