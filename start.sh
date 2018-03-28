#!/bin/bash
# script to bootstrap setting up a machine with ansible 

echo "==========================================="
echo "Setting up your machine using jwhardcastle/setupmachine"
echo "==========================================="

ANSIBLE_CONFIG=

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi


if [[ $platform == 'linux' ]]; then

	which apt

	if ! which apt > /dev/null; then
		echo 'Cannot find apt, exiting.';
		exit 1
	fi

	# Ubuntu needs a bunch of libs before installing Ansible
	sudo sh -c "sudo apt -yf install python-setuptools python-dev libffi-dev libssl-dev"

	sudo easy_install pip
	sudo easy_install ansible

elif [[ $platform == 'osx' ]]; then

	if ! which brew > /dev/null ; then
		echo 'Cannot find brew, exiting.'
		
		exit 1
	fi

	# On OS X, brew doesn't want to use sudo
	if ! brew install openssl; then
		echo 'Cannot install openssl, exiting.'
		
		exit 1
	fi

	if ! brew install ansible; then
		echo 'Cannot install ansible, exiting.'

		exit 1
	fi

fi

# We might be running this locally from a version of the git repo, in that case,
# just run it, no need to clone anything
if [ -e playbook.yml ]; then
    ansible-playbook -Ki ./hosts --ask-vault-pass playbook.yml --verbose
    exit $?
fi

# Else, we're likely running from a cURL so get the repo and run it
installdir="/tmp/setupmachine-$RANDOM"
mkdir $installdir

git clone https://github.com/jwhardcastle/setupmachine.git $installdir 
if [ ! -d $installdir ]; then
    echo "failed to find setupmachine."
    echo "git cloned failed"
    exit 1
else
    cd $installdir 
    ansible-playbook -Ki ./hosts --ask-vault-pass playbook.yml --verbose
fi

echo "cleaning up..."

rm -Rfv $installdir

echo "and we are done! Enjoy!"

exit 0
