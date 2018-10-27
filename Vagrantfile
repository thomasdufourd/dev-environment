# Update me!!!
#--------------
YOUR_NAME = "yourname_here"
HARDWARE_CPUS = 2
HARDWARE_RAM = 2048
#---------------------------------
HARDWARE_DISK = "30GB"
HARDWARE_VRAM = "128"
HARDWARE_3D_ACCELLERATION = "on"
#---------------------------------
VAGRANTFILE_API_VERSION = "2"


vagrant_dir = File.expand_path(File.dirname(__FILE__))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "weignitetech/lubuntu-1804"
  config.vm.box_version = "0.0.1"
  config.vm.hostname = "WIT-dev-"+YOUR_NAME

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.vm.synced_folder(".", "/vagrant",
    :owner => "vagrant",
    :group => "vagrant",
    :mount_options => ['dmode=777','fmode=777']
  )

  config.vm.provider "virtualbox" do |vb|

    # Tell VirtualBox that we're expecting a UI for the VM
    #vb.gui = true

    # Enable sharing the clipboard
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]

    vb.customize ["modifyvm", :id, "--memory", HARDWARE_RAM]
    vb.customize ["modifyvm", :id, "--cpus", HARDWARE_CPUS, "--pae", "on"]

    # Set Northbridge
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]

    # Set the amount of RAM that the virtual graphics card should have
    vb.customize ["modifyvm", :id, "--vram", HARDWARE_VRAM]

    # Advanced Programmable Interrupt Controllers (APICs) are a newer x86 hardware feature
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # Enable the use of hardware virtualization extensions (Intel VT-x or AMD-V) in the processor of your host system
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]

    # Enable, if Guest Additions are installed, whether hardware 3D acceleration should be available
    vb.customize ["modifyvm", :id, "--accelerate3d", HARDWARE_3D_ACCELLERATION]

    # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

  end

  config.vm.provision :shell, path: File.join( "provision", "bootstrap.sh" )

  config.vm.provision :reload

  config.vm.provision :shell, path: File.join( "provision", "provision-as-vagrant-user.sh" ), :privileged => false

  config.vm.provision :reload

end

