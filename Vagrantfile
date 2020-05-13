Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 9600, host: 9600
  config.vm.network "forwarded_port", guest: 5601, host: 5601

  config.vm.network "private_network", ip: "192.168.33.30"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
	vb.cpus = 2
  end
  
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", rebuild: true, run: "always"
  
  config.vm.provision :shell, inline: <<-SHELL
	usermod -aG docker vagrant
  SHELL
    
end
