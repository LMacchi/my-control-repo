# role/manifests/vcs.pp
class role::vcs {
  include profile::base
  include profile::gitlab
}
