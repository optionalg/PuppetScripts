cron {'Backup nginx web server':
  command => '/usr/bin/rsync -az /usr/share/nginx/html/test.local/ /var/spool/backup/',
  hour => '03',
  minute => '00',
}
/*
  Other useful options
  puppet specific
  weekday ex: Monday
  month ex: January
  monthday ex 31

  Standard crons stuff to like the astrick/5
*/
