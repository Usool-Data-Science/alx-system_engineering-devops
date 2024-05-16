# Increase the read write limit for holberton
exec { 'hard-file-limit-increase'
  command => '/sed -i "/^holberton hard/s/4/50000/" /etc/limits.config',
  path    => ['/usr/local/bin/', '/bin/']
}

exec { 'soft-file-limit-increase'
  command => 'sed -i "/^holberton soft/s/5/50000/" /etc/limits.config',
  path    => ['/usr/local/bin/', '/bin/']
}
