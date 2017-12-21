class redsocks::params () {

  $ensure_service = 'running'
  $enable_service = true
  $package_name   = 'redsocks'
  $service_name   = 'redsocks'
  $config_path    = '/etc/redsocks.conf'
  $config_user    = 'root'
  $config_group   = 'root'
  $config_perm    = '0640'
  $log_debug      = 'off'
  $log_info       = 'on'
  $log            = 'syslog:daemon'
  $daemon         = 'on'
  $user           = 'redsocks'
  $group          = 'redsocks'
  $redirector     = 'iptables'
}
