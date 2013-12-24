# ex: si ts=4 sw=4 et

class redsocks::debian {
    file { '/etc/default/redsocks':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/redsocks/Debian/default',
    }
}
