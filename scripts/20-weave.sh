#!/bin/bash

# stop on error
set -e

# stop if weave is installed
command -v weave && exit 0

# install weave
sudo curl -L git.io/weave -o /usr/local/bin/weave
sudo chmod a+x /usr/local/bin/weave

