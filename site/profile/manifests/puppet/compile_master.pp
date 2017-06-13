# Class to configure Compile Masters
class profile::puppet::compile_master {
  @@haproxy::balancermember { "haproxy_${::hostname}":
    listening_service => 'puppet00',
    ports             => '8140',
    server_names      => $::hostname,
    ipaddresses       => $::ipaddress,
    options           => 'check',
  }
}
