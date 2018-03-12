# @summary Role for Continuous Integration using Jenkins
class role::ci {
  include ::profile::base
  include ::profile::jenkins2
}
