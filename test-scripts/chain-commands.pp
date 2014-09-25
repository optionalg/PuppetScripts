exec{'command-1':
  command => '/bin/echo Step 1',
}

exec{'command-2':
  command => '/bin/echo Step 2',
  require => Exec['command-1'],
}

exec{'command-3':
  command => '/bin/echo Step 3',
  require => Exec['command-2'],
}

