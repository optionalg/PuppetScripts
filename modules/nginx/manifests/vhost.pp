# Setup an nginx virtual host

define nginx::vhost($site_domain,$site_aliases = []) {
  include nginx
  $site_name = $name
  file {"/etc/nginx/conf.d/${site_name}.conf":
    content => template('nginx/vhost.conf.erb'),
    notify => Service['nginx'],
  }
  file{"/var/www/${site_name}":
    ensure=>'directory',
  }
}
