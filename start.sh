#!/bin/bash
# script to bootstrap setting up a machine with ansible 

echo "==========================================="
echo "Setting up your machine using jwhardcastle/setupmachine"
echo "==========================================="

# Ubuntu needs a bunch of libs before installing Ansible
sudo sh -c "which apt && apt -yf install python-setuptools python-dev libffi-dev libssl-dev"

sudo easy_install pip
sudo easy_install ansible

installdir="/tmp/setupmachine-$RANDOM"
mkdir $installdir

exit 0

git clone https://github.com/jwhardcastle/setupmachine.git $installdir 
if [ ! -d $installdir ]; then
    echo "failed to find setupmachine."
    echo "git cloned failed"
    exit 1
else
    cd $installdir 
    ansible-playbook -i ./hosts playbook.yml --verbose
fi

echo "cleaning up..."

rm -Rfv $installdir

echo "and we are done! Enjoy!"

exit 0
