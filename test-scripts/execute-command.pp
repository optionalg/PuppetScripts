exec {'Test command search path':
  command => 'echo Ran on `date` > /tmp/datestamp.txt',
  path => ['/bin','/usr/bin'],
}
