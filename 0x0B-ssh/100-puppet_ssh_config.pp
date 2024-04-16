#A puppet manifest for setting up ssh
$key_path='/home/ubuntu/.ssh/school'
$conf_path='/home/ubuntu/.ssh/config'
$key_dir='/home/ubuntu/.ssh'
$config_content="Host *\n\tUser ubuntu\n\tPasswordAuthentication no\n\tIdentityFile /home/ubuntu/.ssh/school"

exec { 'ssh-keygen':
  command => '/usr/bin/ssh-keygen -f school -b 4096 -N betty'
}

file { $key_dir:
  ensure  => 'directory',
  mode    => '0700',
  require => Exec['ssh-keygen']
}

file { $key_path:
  ensure => 'present'
}

file { $conf_path:
  ensure  => 'present',
  content => $config_content,
  mode    => '0600'
}
