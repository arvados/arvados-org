#!/bin/bash

# Copyright (C) The Arvados Authors. All rights reserved.
#
# SPDX-License-Identifier: AGPL-3.0

REVISION=$1

if [[ "$REVISION" == "" ]]; then
  echo
  echo "Syntax: $0 git-revision"
  echo
  exit 1
fi

JSON=`curl -s http://versions.arvados.org/v1/commit/$REVISION`

echo "versions:"
echo "  default-docker-jobs-image-hash: "`echo $JSON | jq -r .Versions.Docker.\"arvados/jobs\"`
echo $JSON |jq -r .Versions.Gem |grep ':' |sed -e 's/[",]//g' -e 's/:/-gem:/'
echo $JSON |jq -r .Versions.Distribution |grep ':' |sed -e 's/[",]//g' -e 's/$/\*/'

