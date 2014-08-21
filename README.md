# Vagrant puphpet samba
vagrant shell script to set up samba share between guest webroot and host

## Use
1. cd /vagrant/puphpet/shell
2. git clone git@github.com:ashlewis/vagrant-puphpet-samba.git .
3. add content of Vagrantfile-add to /vagrant/Vagrantfile before closing "end"
4. vagrant provision
5. map network drive on host machine to guest share e.g. \\192.168.55.101\www using credential vagrant:vagrant
6. **NOTE**: highly insecure - only use for local dev box  


