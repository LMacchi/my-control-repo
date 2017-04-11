class profile::proxy {
  include ::haproxy
  haproxy::listen { 'puppet00':
    mode      => 'tcp',
    ipaddress => $::ipaddress,
    ports     => '8140',
    options   => {
      'option'  => [
        'tcplog',
      ],
      'balance' => 'leastconn',
    },
  }
}
