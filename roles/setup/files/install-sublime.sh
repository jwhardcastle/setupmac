#!/bin/bash

# Get the latest version of Sublime 3 from the website, download the deb, and install

#BUILD=`curl -s http://www.sublimetext.com/updates/3/stable/updatecheck?platform=linux | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["latest_version"]'`
#echo Found latest Sublime Text build: ${BUILD}
#URL=https://download.sublimetext.com/sublime-text_build-${BUILD}_amd64.deb
#cd /tmp
#wget $URL
#sudo sh -c "dpkg --install sublime-text_build-${BUILD}_amd64.deb && rm -f sublime-text_build-${BUILD}_amd64.deb"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
