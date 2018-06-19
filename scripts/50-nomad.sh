#!/bin/bash

set -e # stop on error

command -v nomad &&  exit 0 # stop if nomad is installed

mkdir -p /var/lib/nomad

version=0.8.4

sudo apt install unzip

wget https://releases.hashicorp.com/nomad/${version}/nomad_${version}_linux_amd64.zip
unzip nomad_${version}_linux_amd64.zip
rm nomad_${version}_linux_amd64.zip
chmod +x nomad

sudo mv nomad /usr/local/bin/nomad

nomad -v

