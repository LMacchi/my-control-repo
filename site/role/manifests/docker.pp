# @summary Role to create a box that serves as a Docker host
class role::docker {
  include ::profile::base
  include ::profile::docker
}
