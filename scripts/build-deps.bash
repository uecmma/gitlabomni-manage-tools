#!/bin/bash

set -exo pipefail

echo 'not implemented'
exit 1

# TODO:
# * prefix supports
# * more testings
# * more flexible
# * create dep file

GITLAB_MANAGE_ETC_DIR='/etc/gitlab-manage'
GITLAB_MANAGE_VAR_DIR='/var/lib/gitlab-manage'

# place config.yaml
mkdir -p $GITLAB_MANAGE_ETC_DIR
cat > $GITLAB_MANAGE_ETC_DIR/config.yaml <<EOS
general:
  data_dir: $GITLAB_MANAGE_VAR_DIR/data
  cache_dir: $GITLAB_MANAGE_VAR_DIR/cache

mail:
  enable: false

  host: localhost
  port: 25

  show_diff: true
EOS

# make data_dir
mkdir -p $GITLAB_MANAGE_VAR_DIR/data
# make cache_dir
mkdir -p $GITLAB_MANAGE_VAR_DIR/cache
