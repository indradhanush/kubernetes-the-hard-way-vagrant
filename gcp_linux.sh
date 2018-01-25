#!/bin/bash

set -xue

gcloud compute instances create linux2 \
       --async \
       --boot-disk-size 200GB \
       --can-ip-forward \
       --image-family ubuntu-1604-lts \
       --image-project ubuntu-os-cloud \
       --machine-type n1-standard-1 \
       --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
       --subnet default \
       --tags linux2


# Commands

# Setup tools

sudo apt-get install byobu emacs -y

# Setup hab

sudo apt-get update -y

curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash

wget https://api.bintray.com/content/habitat/stable/linux/x86_64/hab-%24latest-x86_64-linux.tar.gz?bt_package=hab-x86_64-linux

mv hab* hab.tar.gz

tar zxvf hab.tar.gz

sudo mv hab*/hab /usr/local/bin

rm -r hab*

# Setup docker

sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual -y

sudo apt-get update -y

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# For ubuntu artful
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu zesty stable"

sudo apt-get update -y

sudo apt-get install docker-ce


sudo usermod -G docker dhanush

# logout and login
