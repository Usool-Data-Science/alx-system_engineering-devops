#A puppet manifest for setting up ssh
$key_path='/home/ubuntu/.ssh/school'
$conf_path='/etc/ssh/ssh_config'
$key_dir='/home/ubuntu/.ssh'
$config_content="Include /etc/ssh/ssh_config.d/*.conf\n\tHost *\n\tUser ubuntu\n\tPasswordAuthentication no\n\tIdentityFile /home/ubuntu/.ssh/school"

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
}
