# ex: si ts=4 sw=4 et

class redsocks::debian (
  $config_path = $::redsocks::config_path
){
    file { '/etc/default/redsocks':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('redsocks/debian_default.erb'),
    }
}
