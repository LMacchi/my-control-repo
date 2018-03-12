# @summary Role to provision a PE MoM
class role::puppet::master {
  include ::profile::base
  include ::profile::puppet::master
  include ::profile::puppet::classifier
  include ::profile::vra_config
}
