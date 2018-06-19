#!/bin/bash

set -e  # stop on error

# stop if consul is installed
command -v consul && exit 0 || true

mkdir -p /var/lib/consul

sudo apt install -y unzip

version=1.1.0
wget https://releases.hashicorp.com/consul/${version}/consul_${version}_linux_amd64.zip
unzip consul_${version}_linux_amd64.zip
rm consul_${version}_linux_amd64.zip
chmod +x consul

sudo mv consul /usr/local/bin/consul

consul -v

