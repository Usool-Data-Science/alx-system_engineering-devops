#A puppet manifest for setting up ssh
$key_path='~/.ssh/school'
$conf_path='~/.ssh/config'
$key_dir='~/.ssh'
$config_content="Host *\n\tUser ubuntu\n\tPassAuthentication no\n\tIdentityFile ${key_path}"

file { $key_dir:
  ensure => 'directory',
  mode   => '0700'
}

file { $key_path:
  ensure => 'present'
}

file { $conf_path:
  ensure  => 'present',
  content => $config_content
}
