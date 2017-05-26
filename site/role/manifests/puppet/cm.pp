# @summary Role that provisions a PE Compile Master
class role::puppet::cm {
  include profile::base
  include profile::puppet::compile_master
}
