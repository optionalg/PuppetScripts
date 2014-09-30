if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}


node 'git-master' {
  include nginx
  include git-server
  nginx::vhost {'test-local':
    site_domain => 'test.local',
  }
}

node 'git-demo2' {
  include puppet-mgr
}
