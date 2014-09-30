# Setup an nginx virtual host

define nginx::vhost($site_domain) {
  include nginx
  $site_name = $name
  file {"/etc/nginx/conf.d/${site_name}.conf":
    content => template('nginx/vhost.conf.erb'),
    notify => Service['nginx'],
  }
  file{"/usr/share/nginx/html/${site_name}":
    ensure=>'directory',
  }
  file{"/usr/share/nginx/html/$site_name/index.html":
    source=>'puppet:///modules/nginx/index.html',
    notify=>Service['nginx'],
  }
}
