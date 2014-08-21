#!/bin/bash
#
VAGRANT_CORE_FOLDER=$(cat '/.puphpet-stuff/vagrant-core-folder.txt')

OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
RELEASE=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" RELEASE)
CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)

echo 'Adding user password'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    echo vagrant:vagrant | chpasswd

elif [[ "${OS}" == 'centos' ]]; then
    echo vagrant | passwd vagrant --stdin
fi

echo 'Disabling vm firewall'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    iptables -F
    ufw disable
    
elif [[ "${OS}" == 'centos' ]]; then
    service iptables save
    service iptables stop
    chkconfig iptables off

    service ip6tables save
    service ip6tables stop
    chkconfig ip6tables off
fi

echo 'Adding Samba config'
printf "[www]\n    comment = Samba share\n    read only = no\n    browseable = yes\n    writable = yes\n    guest ok = yes\n    path = /var/www" >> /etc/samba/smb.conf

echo 'Adding Samba user/password'
(echo "vagrant"; echo "vagrant") | smbpasswd -s -a vagrant

echo 'Restarting Samba'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    service smbd restart
    
elif [[ "${OS}" == 'centos' ]]; then
    /sbin/service smb restart
fi

echo 'Setting share directory permissions'
chown vagrant /var/www/ -R
chmod 777 /var/www/ -R