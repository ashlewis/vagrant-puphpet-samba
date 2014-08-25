# Vagrant samba share
Vagrant shell scripts to set up samba share between guest webroot and host

The scripts can be run by vagrant using ONE of the 2 following methods:

1. Using PuPHPet provisioning files directories (recommended)
1. Adding to scripts directory and editing Vagrantfile  

## Usage
### 1) Using PuPHPet provisioning files directories (recommended)
1. In Firewall Rules section on puphpet.com, Add Firewall Rule: 445/100/tcp/accept
1. Copy samba-share.sh to <host>\<your_env>\puphpet\files\exec-once\ (or <guest>/vagrant/puphpet/files/exec-once/)
1. Copy samba-start.sh to <host>\<your_env>\puphpet\files\startup-always\ (or <guest>/vagrant/puphpet/files/startup-always/)
1. vagrant up / vagrant provision
1. map network drive on host machine to guest share e.g. \\192.168.12.345\www using credential vagrant:vagrant

### 2) Adding to scripts directory and editing Vagrantfile
1. In Firewall Rules section on puphpet.com, Add Firewall Rule: 445/100/tcp/accept
1. Copy samba-share.sh to <host>\<your_env>\puphpet\shell\ (or <guest>/vagrant/puphpet/shell/)
1. Copy samba-start.sh to <host>\<your_env>\puphpet\shell\ (or <guest>/vagrant/puphpet/shell/)
1. Add content of Vagrantfile-add to /vagrant/Vagrantfile before closing "end"
1. vagrant up / vagrant provision
1. map network drive on host machine to guest share e.g. \\192.168.12.345\www using credential vagrant:vagrant