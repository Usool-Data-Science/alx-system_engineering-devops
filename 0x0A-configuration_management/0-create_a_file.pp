# Create a file in /tmp
$file_path = '/tmp/school'

file { $file_path:
  content => 'I love Puppet',
  mode => '0744',
  owner => 'www-data',
  group => 'www-data'
}
