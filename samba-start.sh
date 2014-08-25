#!/bin/bash
#
VAGRANT_CORE_FOLDER=$(cat '/.puphpet-stuff/vagrant-core-folder.txt')

OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
RELEASE=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" RELEASE)
CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)

echo 'Restarting Samba'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    service smbd restart
    
elif [[ "${OS}" == 'centos' ]]; then
    /sbin/service smb restart
fi