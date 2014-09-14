class nginx {
  package {'nginx':
    ensure => installed,
  }
  service {'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }
  file{'/etc/nginx/conf.d/test.local.conf':
    source=>'puppet:///modules/nginx/test.local.conf',
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
	
