class redsocks::config (
  $config_path  = $::redsocks::config_path,
  $config_user  = $::redsocks::config_user,
  $config_group = $::redsocks::config_group,
  $config_perm  = $::redsocks::config_perm,
  $package_name = $::redsocks::package_name,
  $service_name = $::redsocks::service_name,
  $log_debug    = $::redsocks::log_debug,
  $log_info     = $::redsocks::log_info,
  $log          = $::redsocks::log,
  $daemon       = $::redsocks::daemon,
  $user         = $::redsocks::user,
  $group        = $::redsocks::group,
  $redirector   = $::redsocks::redirector,
  $redsocks     = $::redsocks::redsocks,
  $redudps      = $::redsocks::redudps,
  $dnstc        = $::redsocks::dnstc
) inherits redsocks {

  concat { $config_path:
    ensure  => present,
    owner   => $config_user,
    group   => $config_group,
    mode    => $config_perm,
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  concat::fragment { 'redsocks_base':
    target  => $config_path,
    content => template('redsocks/redsocks_base.conf.erb'),
    order   => '01',
  }

  $redsocks.each |$index, $redsock| {
    $instance_name  = $index
    $local_ip       = $redsock['local_ip']
    $local_port     = $redsock['local_port']
    $proxy_ip       = $redsock['proxy_ip']
    $proxy_port     = $redsock['proxy_port']
    $proxy_type     = $redsock['proxy_type']
    $proxy_login    = $redsock['proxy_login']
    $proxy_password = $redsock['proxy_password']

    concat::fragment { "redsocks_redsocks_${instance_name}":
      target  => $config_path,
      content => template('redsocks/redsocks_redsocks.conf.erb'),
      order   => '02',
    }
  }

  $redudps.each |$index, $redudp| {
    $instance_name      = $index
    $local_ip           = $redudp['local_ip']
    $local_port         = $redudp['local_port']
    $proxy_ip           = $redudp['proxy_ip']
    $proxy_port         = $redudp['proxy_port']
    $proxy_login        = $redudp['proxy_login']
    $proxy_password     = $redudp['proxy_password']
    $dest_ip            = $redudp['dest_ip']
    $dest_port          = $redudp['dest_port']
    $udp_timeout        = $redudp['udp_timeout']
    $udp_timeout_stream = $redudp['udp_timeout_stream']

    concat::fragment { "redsocks_redudps_${instance_name}":
      target  => $config_path,
      content => template('redsocks/redsocks_redudps.conf.erb'),
      order   => '03',
    }
  }

  if ($dnstc != []) {
    $dnstc_local_ip   = $dnstc['local_ip']
    $dnstc_local_port = $dnstc['local_port']

    concat::fragment { 'redsocks_dnstc':
      target    => $config_path,
      content   => template('redsocks/redsocks_dnstc.conf.erb'),
      order     => '04',
    }
  }
}
