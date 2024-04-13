# Installs flask version 2.1.0
package {'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
  required => Package['pip3']
}

package { 'pip3':
    ensure => "installed"
}
