Vagrant.configure("2") do |config|
  config.vm.define "windows" do |windows|
    windows.vm.box = "gusztavvargadr/windows-10"
    windows.vm.communicator = "winrm"
    windows.vm.network "forwarded_port", guest: 5985, host: 55986
    windows.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
  end
end
