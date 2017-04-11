class profile::compile_master {
  @@haproxy::balancermember { 'haproxy':
    listening_service => 'puppet00',
    ports             => '8140',
    server_names      => $::hostname,
    ipaddresses       => $::ipaddress,
    options           => 'check',
  }
}
