#!/bin/sh

export PUPPET_REPO=/home/puppet-mgr/puppet-control
/usr/bin/puppet apply $PUPPET_REPO/manifests/site.pp --modulepath=$PUPPET_REPO/modules/ $*
