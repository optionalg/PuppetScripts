# basic round cube setup

# receives the product name, db connection string, and then des_key
# product name defaults to the standard roundcube webmail
# des_key defaults to the default string which won't be accepted

class roundcubemail (
    $product_name = 'Roundcube Webmail',
    $dbstring = '',
    $des_key = 'rcmail-!24ByteDESkey*Str') {


  package {'roundcubemail':
    ensure => installed,
  }

  file {'/etc/roundcubemail/config.inc.php':
    content => template('roundcubemail/config.inc.php.erb'),
  }

}
