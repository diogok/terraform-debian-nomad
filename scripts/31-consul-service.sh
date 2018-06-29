#!/bin/bash

set -e # stop on error

consul members && exit 0  # stop if active

. /etc/ops/env # load config

sudo mv /etc/ops/consul.service /etc/systemd/system/consul.service

echo CONSUL_UI_BETA=true >> /etc/ops/env
echo '{"connect":{"enabled":true}}' > /etc/ops/consul.json

if [ "$ROLE" == "manager" ]; then
  echo CONSUL_ROLE_FLAGS="-server -bootstrap-expect=1" >> /etc/ops/env
fi

if [ "$ROLE" != "manager" ]; then
  echo CONSUL_ROLE_FLAGS= >> /etc/ops/env
fi

cat /etc/systemd/system/consul.service

sudo systemctl daemon-reload
sudo systemctl start consul

