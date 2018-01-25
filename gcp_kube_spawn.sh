#!/bin/bash

set -xue

gcloud compute instances create kubespawn \
       --async \
       --boot-disk-size 200GB \
       --can-ip-forward \
       --image-family ubuntu-1710 \
       --image-project ubuntu-os-cloud \
       --machine-type n1-standard-1 \
       --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
       --subnet default \
       --tags kubespawn


# Commands

# Setup hab

sudo apt-get update -y

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

sudo apt-get update -y

sudo apt-get install docker-ce

sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker

# Setup regular stuff

sudo apt-get install emacs25 -y
sudo apt-get install gcc make -y

# Setup up Golang

## download and extract

echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
echo "export GOPATH=$HOME/go" >> ~/.bashrc

source ~/.bashrc

echo "package main \

import \"fmt\" \

func main() { \
    fmt.Printf(\"hello, world\\n\") \
}" > $HOME/go/src/hello/hello.go


# kube-spawn

sudo apt-get install systemd-container -y
