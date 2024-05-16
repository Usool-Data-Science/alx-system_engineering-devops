# Increase the ulimit from 15 to 4096 which is the hard limit

exec { 'debug-nginx':
  # Modify the soft limit
  command => '/bin/sed -i "s/15/4096" /etc/default/nginx',
  # Indicate the path where the command will be found
  path    => ['/usr/local/bin/', '/bin/'],
}


exec { 'nginx-restart':
  command => '/etc/init.d/nginx restart',
  path    => ['/etc/init.d/'],
  require => Exec['debug-nginx'],
}
