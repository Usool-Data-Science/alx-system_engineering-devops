#A puppet manifest for setting up a server

# Global variables
$root_path = '/var/www/html'
$root_content = 'Hello World!'
$server_content = "server {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server ipv6only=on;\n\troot /var/www/html;\n\tindex index.html;\n\tadd_header X-Served-By \$hostname;\n\tlocation /redirect_me {\n\treturn 301 http://example.com/;\n}\n}"


# Update application list
exec  { 'Update':
    command => '/usr/bin/apt-get update',
}

# Install nginx
package { 'nginx':
    ensure  => 'installed',
    require => Exec['Update']
}

# Create root directory
file { $root_path:
    ensure => 'directory',
    mode   => '0755'
}

# Populate the root html file
file { "${root_path}/index.html":
    ensure  => 'present',
    content => $root_content,
    notify  => Service['nginx'],
    require => File[$root_path]
}

# Replace the server setup
file { '/etc/nginx/sites-available/default':
    content => $server_content;
    ensure  => 'present',
    notify  => Service['nginx']
}

# Reload/Restart Nginx
service { 'nginx':
    ensure => 'running',
    enable => 'true'
}

