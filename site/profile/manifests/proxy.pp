# Class to configure a load balancer
# using HAProxy
class profile::proxy {
  class { '::haproxy':
    defaults_options => {
      'log'     => 'global',
      'stats'   => 'enable',
      'maxconn' => '8000',
    },
  }

  haproxy::listen { 'puppet00':
    mode      => 'tcp',
    ipaddress => '0.0.0.0',
    ports     => '8140',
    options   => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'leastconn',
    },
  }
}
