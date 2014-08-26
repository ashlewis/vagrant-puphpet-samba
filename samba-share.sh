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

if ! grep -R "\[www\]" "/etc/samba/smb.conf"; then
    echo 'Adding Samba config'
    printf "[www]\n    comment = Samba share\n    read only = no\n    browseable = yes\n    writable = yes\n    guest ok = yes\n    path = /var/www" >> /etc/samba/smb.conf
fi

echo 'Adding Samba user/password'
(echo "vagrant"; echo "vagrant") | smbpasswd -s -a vagrant

echo 'Setting share directory permissions'
chown vagrant:www-data /var/www/ -R
chmod 755 /var/www/ -R
