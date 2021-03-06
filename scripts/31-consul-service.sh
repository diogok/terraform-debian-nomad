#!/bin/bash

set -e # stop on error

consul members && exit 0  # stop if active

. /etc/ops/env # load config

sudo mv /etc/ops/consul.service /etc/systemd/system/consul.service

echo CONSUL_UI_BETA=true >> /etc/ops/env
echo '{"connect":{"enabled":true}}' > /etc/ops/consul.json

NAMESERVER=`cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }' | head -n1`
echo NAMESERVER=$NAMESERVER >> /etc/ops/env

if [ "$ROLE" == "manager" ]; then
  echo CONSUL_ROLE_FLAGS=\"-server -bootstrap-expect=1\" >> /etc/ops/env
fi

if [ "$ROLE" != "manager" ]; then
  echo CONSUL_ROLE_FLAGS=-server >> /etc/ops/env
fi


cat /etc/systemd/system/consul.service

sudo systemctl daemon-reload
sudo systemctl enable consul
sudo systemctl start consul

