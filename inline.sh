#!/bin/bash

   HST=$(hostname)

   . /vagrant/.function

#
#  Would really like to get the 3.2.8 version.  So, ahem, relying on the community.
#
   echo "Installing redis-server..."
   (
   add-apt-repository -y ppa:chris-lea/redis-server
   apt-get -y update 
   apt-get -y install redis-server 
   ) 1> /dev/null 2>&1
   which redis-server

#
#  The unzip command is not available on this image...hmmmm
#
   apt-get -y install unzip

#
#  Will need this later
#
   gem install redis

   install_consul

#
#  Need to try to make this work later - preferably with a Dockerfile, not via command line
#
   #docker run -d -p 6379:6379 -v redis.conf:/usr/local/etc/redis/redis.conf --name rinst redis redis-server /usr/local/etc/redis/redis.conf

#
#  Check if some things are installed...
#
   consul --version
   redis-server --version
   redis-cli ping
#
#  Now we need configure, restart and verify
#
   configure_server
   set -x
   nohup consul agent -config-file=/var/consul/${HST}.json 1> /var/log/consul.log 2>&1 &
   service redis-server restart
   redis-benchmark -q -n 1000 -c 10 -P 5
   redis-cli -h localhost -p 6379 INFO | grep role 
   set +x

exit 0
