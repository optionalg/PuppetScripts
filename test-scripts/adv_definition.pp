# Setup a definition and then use it

define script_job($hour = '00',$minute = '00') {
  file{"/usr/local/bin/${name}":
    source => "puppet:///modules/scripts/${name}",
    mode => '0755',
  }

  cron { "Run ${name}":
    command => "/usr/local/bin/${name}",
    hour => $hour,
    minute => $minute,
  }
}

script_job {'backup_database':
  hour => '05',
  minute => '00',
}
