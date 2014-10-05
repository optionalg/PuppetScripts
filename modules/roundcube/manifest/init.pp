#set the NTP server on the host

class roundcubemail () {
  package {'roundcubemail':
    ensure => installed,
  }

}
