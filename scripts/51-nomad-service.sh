#!/bin/bash

set -e # stop on error

nomad status && exit 0

. /etc/ops/env # load config

echo 'client { options { docker.privileged.enabled = "true" "driver.raw_exec.enable" = "1"} }' > /etc/ops/nomad.hcl

if [ "$ROLE" == "manager" ]; then
  echo NOMAD_ROLE_FLAGS=\"-server -bootstrap-expect=1\" >> /etc/ops/env
fi

if [ "$ROLE" != "manager" ]; then
  echo NOMAD_ROLE_FLAGS=-client -config=/etc/ops/nomad.hcl >> /etc/ops/env
fi

sudo mv /etc/ops/nomad.service /etc/systemd/system/nomad.service
cat /etc/systemd/system/nomad.service

sudo systemctl daemon-reload
sudo systemctl enable nomad
sudo systemctl start nomad

