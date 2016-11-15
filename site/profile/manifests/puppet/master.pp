# profile/manifests/puppet/master.pp
class profile::puppet::master {
  class { 'hiera':
    hierarchy => [
      'nodes/%{::fqdn}',
      'datacenters/%{::datacenter}',
      'networks/%{::networkzone}',
      'common',
    ],
  }
}
