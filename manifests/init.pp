class redsocks (
	$bind_address     = '127.0.0.1',
	$bind_port        = '12345',
	$proxy_address    = '127.0.0.1',
	$proxy_port       = '1080',
	$proxy_user       = '',
	$proxy_password   = '',
	$bind_udp_port    = '10053',
	$udp_dest_address = '8.8.8.8',
	$udp_dest_port    = '53',
	$dns_address      = '127.0.0.1',
	$dns_port         = '5300',
) {

	package { 'redsocks':
		ensure => latest,
	}

	file { '/etc/redsocks.conf':
		ensure  => present,
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		content => template('redsocks/redsocks.conf.erb'),
		require => Package['redsocks'],
	}

	service { 'redsocks':
		ensure => running,
		require => File['/etc/redsocks.conf'],
	}

}
