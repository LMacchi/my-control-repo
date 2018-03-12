# @summary Role to create a Bitbucket server
class role::bitbucket {
  include ::profile::base
  include ::profile::bitbucket
}
