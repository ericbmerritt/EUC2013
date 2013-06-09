# -*- mode: Ruby; fill-column: 80; comment-column: 75; -*-

Vagrant.configure("2") do |config|

  config.vm.box = "CentOS-6.3-x86_64-minimal"

  config.vm.network :forwarded_port, guest: 22, host: 2450, id: "ssh"
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.vm.synced_folder "./", "/EUC2013"

  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "./EUC2013.yml"
    ansible.inventory_file = "./vagrant.ini"
    ansible.verbose = true
  end
end
