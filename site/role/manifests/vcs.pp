# role/manifests/vcs.pp
# @summary Version Control Server provisioned via Gitlab
class role::vcs {
  include ::profile::base
  include ::profile::gitlab
}
