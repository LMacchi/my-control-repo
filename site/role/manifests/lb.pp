# @summary Role to configure a Load Balancer using haproxy
class role::lb {
  include ::profile::base
  include ::profile::proxy
}
