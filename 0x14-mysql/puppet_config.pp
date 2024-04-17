#Server configuration file using puppet

$root_path = '/var/www/html'
$root_content = 'Hello World!'
$default_path = '/etc/nginx/sites-available/default'
$firewall_content = '[CustomService]\ntitle=My customer firewall\ndescription=Open firewall access to the following ports\nports=8-,443,22/tcp'
$server_content = "server {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server;\n\troot /var/www/html;\n\tindex.html;\n}\n}"

# Update the application package manager
exec { 'update':
  command => '/usr/bin/apt-get update'
}

# Open firewall to some ports
file { '/etc/ufw/applications.d/web_services':
  ensure  => 'present',
  content => $firewall_content
}
exec { 'ufw-reload':
  command => '/usr/bin/sudo service ufw reload'
  require => File['/etc/ufw/applications.d/web_services']
}

####### DATABASE SETUP #################
# Install mysql server
package { 'mysql-server':
  ensure  => 'installed',
  require => Exec['update']
}
# Start mysql server
exec {
  command => '/usr/bin/sudo systemctl start mysql.service',
  require => Package['mysql-server']
}
####### WEBSERVER SETUP ################

# Install nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update']
}

# Create the root directory
file { $root_path:
  ensure => 'directory',
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755'
}

# Create the root html file.
file { "${root_path}/index.html":
  ensure  => 'present',
  content => $root_content,
  notify  => Service['nginx'],
  require => File[$root_path]
}

# Configure ngixn
file { $default_path:
  ensure  => 'present',
  content => $server_content,
  notify  => Service['nginx']
}

# Restart nginx
service { 'nginx':
  ensure => 'running',
  enable => 'true'
}
