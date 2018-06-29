#!/bin/bash

set -e # stop on error

command -v nomad &&  exit 0 # stop if nomad is installed

sudo mkdir -p /var/lib/nomad

command -v unzip || sudo apt install -y unzip

version=0.8.4
arch=$(arch)
[[ "$arch" == "armv6l" ]] && arch="arm"

wget https://releases.hashicorp.com/nomad/${version}/nomad_${version}_linux_${arch}.zip
unzip nomad_${version}_linux_${arch}.zip
rm nomad_${version}_linux_${arch}.zip
chmod +x nomad

sudo mv nomad /usr/local/bin/nomad

nomad -v

