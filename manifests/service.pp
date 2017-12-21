class redsocks::service () inherits redsocks {

  service { $::redsocks::service_name:
    ensure  => $::redsocks::ensure_service,
    enable  => $::redsocks::enable_service,
  }
}
