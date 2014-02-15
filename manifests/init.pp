# ex: si ts=4 sw=4 et

class redsocks (
    $bind_address,
    $bind_port,
    $proxy_address,
    $proxy_port,
    $proxy_user,
    $proxy_password,
    $bind_udp_port,
    $udp_dest_address,
    $udp_dest_port,
    $dns_address,
    $dns_port,
    $classes,
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
        notify  => Service['redsocks'],
    }

    service { 'redsocks':
        ensure  => running,
    }

    unless (empty($classes)) {
        class { $classes: }
    }
}
