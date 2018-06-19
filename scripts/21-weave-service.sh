#!/bin/bash

set -e # stop on error

. /etc/ops/env

weave status && exit 0  # stop if active

cat /etc/systemd/system/weave.service
sudo systemctl daemon-reload

[[ "$ROLE" != "manager" ]] && sleep 10

sudo systemctl start weave

