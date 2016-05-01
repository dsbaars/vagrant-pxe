# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

VCPUS = 2
VMEM = 2048

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "puphpet/ubuntu1404-x64"
    config.vm.hostname = "pxeserver"
    config.vm.network "public_network"

    # changed vagrant home
    # config.ssh.private_key_path = [
    #   "#{ENV['HOME']}/.vagrant.d/insecure_private_key"
    # ]
    # config.ssh.insert_key = false


    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.customize ["modifyvm", :id, "--memory", VMEM]
        vb.customize ["modifyvm", :id, "--cpus", VCPUS]
    end

    config.vm.provider "parallels" do |prl|
        prl.customize ["set", :id, "--longer-battery-life", "off"]
        prl.memory = VMEM
        prl.cpus =  VCPUS
    end

    config.vm.synced_folder "pxe", "/pxe"
    config.librarian_puppet.puppetfile_dir = "puppet"

    config.vm.provision "puppet" do |puppet|
        puppet.environment_path = "puppet/environments"
        puppet.environment = "production"
        puppet.module_path = "puppet/modules"
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'site.pp'
#        puppet.options = "--verbose --debug"
    end
end
