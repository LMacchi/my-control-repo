# @summary Role to provision a PE Master
class role::puppet::master {
  include profile::base
  include profile::puppet::master
  include profile::vra_config
}
