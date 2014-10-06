# Setup dovecot imap server


class dovecot (
    dc_user,
    dc_password,
    dc_dbname
  ) {


  package {'dovecot':
    ensure => installed,
  }

  file {'/etc/dovecot/conf.d/10-auth.conf':
    source=>'puppet:///modules/puppet/known_hosts',
  }
  file {'/etc/dovecot/dovecot-sql.conf.ext':
    content => template('dovecot/dovecot-sql.conf.ext'),
  }

}
