# Used to define/realize users on Puppet-managed systems
#
class git-server {
  package {'git':
    ensure => installed,
  }
 
  user { 'git-server':
    ensure            =>  'present',
    uid               =>  448,
    gid               =>  'git-server',
    shell             =>  '/usr/bin/git-shell',
    home              =>  "/home/git-server",
    comment           =>  "Git server account",
#    password          =>  '!',
    managehome        =>  true,
    require           =>  Group['git-server'],
  }
 
  group { git-server:
    gid               =>  448,
  }
 
  file { "/home/git-server":
    ensure            =>  directory,
    owner             =>  'git-server',
    group             =>  'git-server',
    mode              =>  0750,
    require           =>  [ User['git-server'], Group['git-server'] ],
  }

  ssh_authorized_key {'git-master':
    user => 'git-server',
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDq2OrYot4bTVz4ytnqz/apdY/iN/YjaoUMpRLA3U/SNdkkZKm5G/1KfYECqxELNRjxZiFePfzEDRDT3ICg8RNomeKGMOydGtS0vO2M10FidQN0z9Wd8ECvT+g+8BKfirP7Nr6XbSSXsNhzZK142/4BpJP8YEZKYOMuTYQpNEOqCzNcUufwjeTxshebrBJqyeUCcI5YIofXTUKNjyZ5aB2uFkCiczpuj9x7tIMGVaH+6NRtsYvn069bzARq1KQhwyP9PeU1GB8qwaQYob5W5cS6SMyJ8lzA7s3ocY2vNKlnYL55HsGnUU+QxiNwinrIgBeBgtIda9wkimTD8HyNbxSR',
  }
  ssh_authorized_key {'git-demo2':
    user => 'git-server',
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDOHaubdAKT5F7RhJybgm6T3GG7D/GfQkjNxA5UkoMjR4GaXUh45LqfuErL46qhOx/fZMgF4Iy5Y8OeZ8oVaNyxqJsHC0L7vD28gpQiOeFfpABCGdqP8oRYotnL3opjm7nOYdYLnyHg8ftHKF+l3fLIKD1W0m+TeuIjgtkjczWj6M3B9dfuD/eEPuDAEnJaAeEYDgEFe3yQ2fVPdLNAwIlFeEeO4/JLzISmX5k9kRtoZMPrxTcIkEQaOXShajpCcx1lV6OOdP5fcmWw41GqeHJu87UhGPk134RmKSqcVqHvEQfvgXsEWzd6QUMzf2jYX/82COKrhb4mn4Ul0DM1pUcf',
  }

}
