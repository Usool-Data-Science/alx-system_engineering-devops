#Server configuration file using puppet

$root_path = '/var/www/html'
$root_content = 'Hello World!'
$default_path = '/etc/nginx/sites-available/default'
$redirection = "server_name _;\n\tlocation /redirect_me {\n\t\treturn 301 https://www.youtube.com/watch?v=MKuELPxZHHU;\n\t}\n"
$server_content = "server {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server ipv6only=on;\n\troot /var/www/html;\n\tindex index.html;\n\tlocation /redirect_me {\n\treturn 301 http://example.com/;\n}\n}"

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

file { $default_path:
  ensure  => 'present',
  content => $server_content,
  notify  => Service['nginx']
}

service { 'nginx':
  ensure => 'running',
  enable => 'true'
}
