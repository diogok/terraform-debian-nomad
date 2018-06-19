#!/bin/bash

set -e # stop on error

consul members && exit 0  # stop if active

. /etc/ops/env # load config

echo CONSUL_UI_BETA=true >> /etc/ops/env

if [ "$ROLE" == "manager" ]; then
  echo CONSUL_ROLE_FLAGS="-server -bootstrap-expect=1" >> /etc/ops/env
fi

if [ "$ROLE" != "manager" ]; then
  echo CONSUL_ROLE_FLAGS= >> /etc/ops/env
fi

cat /etc/systemd/system/consul.service
sudo systemctl daemon-reload
sudo systemctl start consul

