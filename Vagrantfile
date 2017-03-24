# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   #
   # Could 6, 19 or 91 this way, but, I am resoure constrained on my laptop
   # So, just 3 for now.
   #
   (1..3).each do |n|
      config.vm.define "server#{n}" do |node|
         node.vm.box = "ubuntu/trusty64"
         node.vm.hostname = "server#{n}"
         #
         # Just set up a simple local network
         #
         node.vm.network "private_network", ip: "192.168.33.10#{n}"
         #
         # Need to get the docker working later...
         #
         #node.vm.provision "docker" do |d| 
         #   d.pull_images "redis"
         #end
         #
         # Just do it all in a shell for simplicity/flexibility on my part, since this is an exercise
         # Could have used vagrant's ruby code, instead - but, it was left open
         # And, there are a lot of dead-ends on this assignment since this is all new stuff
         # Gotta get something working, first!
         #
         node.vm.provision "shell", :path => "inline.sh"
      end
   end
end
