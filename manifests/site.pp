if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}


node 'git-master' {
  include nginx
  include ntp
  include git-server
  nginx::vhost {'test-local':
    site_domain => 'test.local',
    site_aliases => ['sub1.test.local','sub2.test.local'],
  }
}

node 'git-demo2' {
  include puppet-mgr
  include ntp
}
