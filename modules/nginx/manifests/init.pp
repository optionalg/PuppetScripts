class nginx {
  package {'nginx':
    ensure => installed,
  }
  service {'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }
  file{"/var/www/":
    ensure=>'directory',
    owner=>'root',
    group=>'root',
  }
}
	
