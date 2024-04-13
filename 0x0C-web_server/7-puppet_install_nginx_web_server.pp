#Server configuration file using puppet

$root_path = '/var/www/html'
$root_content = 'Hello World!'
$default_path = '/etc/nginx/sites-available/default'
$redirection = "server_name _;\n\tlocation /redirect_me {\n\t\treturn 301 https://www.youtube.com/watch?v=MKuELPxZHHU;\n\t}\n"

exec { 'update':
  command => '/usr/bin/apt-get update'
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update']
}

file { $root_path:
  ensure => 'directory',
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755'
}

file { "${root_path}/index.html":
  ensure  => 'present',
  content => $root_content,
  notify  => Service['nginx'],
  require => File[$root_path]
}

exec { 'default':
  command => '/usr/bin/sed -i "s,server_name _;,$redirection," $default_path',
  notify  => Service['nginx']
}

service { 'nginx':
  ensure => 'running',
  enable => 'true'
}
