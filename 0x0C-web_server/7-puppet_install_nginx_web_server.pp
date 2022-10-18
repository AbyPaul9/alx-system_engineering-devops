# Puppet script to install Nginx server
package { 'nginx':
  ensure => installed
}

file_line { '404 error page redirection':
  ensure => present,
  path   => '/etc/nginx/sites-enabled/default',
  after  => 'listen \[::\]:80 default_server;',
  line   => 'error_page 404 /404-error.html;',
}

file { '/var/www/html/404-error.html':
  content => "Ceci n'est pas une page",
}

file_line { 'Redirection':
  ensure => present,
  path   => '/etc/nginx/sites-enabled/default',
  after  => 'listen \[::\]:80 default_server;',
  line   => 'rewrite ^/redirect_me / permanent;',
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
