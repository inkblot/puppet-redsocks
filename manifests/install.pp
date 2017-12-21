class redsocks::install {

  package { $::redsocks::package_name:
    ensure  => present,
  }
}
