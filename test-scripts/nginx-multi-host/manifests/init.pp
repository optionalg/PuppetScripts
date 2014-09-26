class nginx {
  package {'nginx':
    ensure => installed,
  }
  service {'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }
  $site_name = 'test_local',
  $site_domain = 'test.local'
  file{'/etc/nginx/conf.d/test.local.conf':
    content=> template('nginx/vhost.conf.erb'),
    notify=>Service['nginx'],
  }
  file{'/usr/share/nginx/html/test.local':
    ensure=>'directory',
  }
  file{'/usr/share/nginx/html/test.local/index.html':
    source=>'puppet:///modules/nginx/index.html',
    notify=>Service['nginx'],
  }
}
	
