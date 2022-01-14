# @api private
class mongodb::client::params inherits mongodb::globals {
  $package_ensure = pick($mongodb::globals::version, 'present')
  $manage_package = pick(
    $mongodb::globals::manage_package,
    (
      $facts['os']['family'] == 'Debian' and
      $facts['os']['release']['major'] == '10'
    )
  )

  if $manage_package {
    $package_name = "mongodb-${mongodb::globals::edition}-shell"
  } else {
    $package_name = $facts['os']['family'] ? {
      'Debian' => 'mongodb-clients',
      'Redhat' => "mongodb-${mongodb::globals::edition}-shell",
      default  => 'mongodb',
    }
  }
}
