# Setup a definition and then use it

define script_job() {
  file{"/usr/local/bin/${name}":
    source => "puppet:///modules/scripts/${name}",
    mode => '0755',
  }

  cron { "Run ${name}":
    command => "/usr/local/bin/${name}",
    hour => '00',
    minute => '00',
  }
}

script_job {'backup_database':
}
