# Used to setup a system as managed by puppet
#
class puppet-mgr {
  package {'git':
    ensure => installed,
  }
  /* guess this goes without saying */
  package {'puppet':
    ensure => installed,
  }
 
  user { 'puppet-mgr':
    ensure            =>  'present',
    uid               =>  449,
    gid               =>  'puppet-mgr',
    shell             =>  '/bin/bash',
    home              =>  "/home/puppet-mgr",
    comment           =>  "puppet manager account",
#    password          =>  '!',
    managehome        =>  true,
    require           =>  Group['puppet-mgr'],
  }
 
  group { puppet-mgr:
    gid               =>  449,
  }
 
  file { "/home/puppet-mgr":
    ensure            =>  directory,
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0750,
    require           =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  # create a directory for the ssh keys to be copied to
  file { "/home/puppet-mgr/.ssh":
    ensure            =>  directory,
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0700,
    require           =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  # create a bin directory for the user
  file { "/home/puppet-mgr/bin":
    ensure            =>  directory,
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0750,
    require           =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  file { "/home/puppet-mgr/.ssh/known_hosts":
    source=>'puppet:///modules/puppet-mgr/known_hosts',
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0600,
    require           =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }
  file { "/home/puppet-mgr/bin/update-repo.sh":
    source=>'puppet:///modules/puppet-mgr/update-repo.sh',
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0755,
    require           =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }
  file { "/home/puppet-mgr/bin/papply.sh":
    source=>'puppet:///modules/puppet-mgr/papply.sh',
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0700,
    require           =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  /*
    on a private system with protected storage and a read only repo,
    this may not be needed but using an exposed github repo, this is
    a safer choice
  */
  exec { "install puppet-mgr ssh keys":
    command => "/bin/cp /home/ec2-user/.ssh/id_rsa* /home/puppet-mgr/.ssh/",
    creates => "/home/puppet-mgr/.ssh/id_rsa",
    require =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  /* now that they are in place, let's ensure the permissions */
  file { "/home/puppet-mgr/.ssh/id_rsa.pub":
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0700,
    require =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }
  file { "/home/puppet-mgr/.ssh/id_rsa":
    owner             =>  'puppet-mgr',
    group             =>  'puppet-mgr',
    mode              =>  0700,
    require =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }
  /* now let's put the repository there */
  exec { "clone puppet-mgr repo":
    command => "/usr/bin/git clone git-server@git-master.us-west-2.compute.internal:puppet-control.git",
    creates => "/home/puppet-mgr/puppet-control",
    user  => "puppet-mgr",
    cwd => "/home/puppet-mgr/",
    require =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  /* before we setup a cron to execute puppet on a regular interval, 
     let's setup the cron job to pull the latest copy of the repo
     down to the local system
  */
  cron {'Backup nginx web server':
    command => '/home/puppet-mgr/bin/update-repo.sh',
    user  => "puppet-mgr",
    hour => '*',
    minute => '*/15',
    require =>  [ User['puppet-mgr'], Group['puppet-mgr'] ],
  }

  /* and the final piece of the puzzle, execute the apply script
     shortly after downloading the updated repository
  */
  cron {'Execute Puppet':
    command => '/home/puppet-mgr/bin/papply.sh',
    user  => "root",
    hour => '*',
    minute => [5,20,35,50],
  }


}
