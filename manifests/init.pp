# ex: si ts=4 sw=4 et

class redsocks (
    $ensure_service = $redsocks::params::ensure_service,
    $enable_service = $redsocks::params::enable_service,
    $package_name   = $redsocks::params::package_name,
    $service_name   = $redsocks::params::service_name,
    $config_path    = $redsocks::params::config_path,
    $config_user    = $redsocks::params::config_user,
    $config_group   = $redsocks::params::config_group,
    $config_perm    = $redsocks::params::config_perm,
    $log_debug      = $redsocks::params::log_debug,
    $log_info       = $redsocks::params::log_info,
    $log            = $redsocks::params::log,
    $daemon         = $redsocks::params::daemon,
    $user           = $redsocks::params::user,
    $group          = $redsocks::params::group,
    $redirector     = $redsocks::params::redirector,
    $redsocks       = {},
    $redudps        = {},
    $dnstc          = []
    ) inherits ::redsocks::params {

    anchor { 'redsocks::begin': } ->
    class { '::redsocks::install': } ->
    class { '::redsocks::config': } ~>
    class { '::redsocks::service': } ->
    anchor { 'redsocks::end': }
}
