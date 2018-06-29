#!/bin/bash

set -e  # stop on error

# stop if consul is installed
command -v consul && exit 0 || true

sudo mkdir -p /var/lib/consul

command -v unzip || sudo apt install -y unzip

version=1.2.0
arch=$(arch)
[[ "$arch" == "armv6l" ]] && arch="arm"

wget https://releases.hashicorp.com/consul/${version}/consul_${version}_linux_${arch}.zip
unzip consul_${version}_linux_${arch}.zip
rm consul_${version}_linux_${arch}.zip
chmod +x consul

sudo mv consul /usr/local/bin/consul

consul -v

