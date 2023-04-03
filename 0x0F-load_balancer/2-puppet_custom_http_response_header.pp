#automate the task of creating a custom HTTP header response, but with Puppet.The name of the custom
#HTTP header must be X-Served-By

exec { 'apt-update':
  command => '/usr/bin/apt update',
}

package { 'nginx':
    ensure  => present,
    require => Exec['apt-update'],
}

file_line {'Adding_Header':
    ensure  => 'present',
    path    => '/etc/nginx/sites-available/default',
    after   => 'listen 80 default_server;',
    line    => 'add_header X-Served-By $hostname;',
    require => Package['nginx'],
}

service { 'nginx':
    ensure  => running,
    require => Package['nginx'],
}
