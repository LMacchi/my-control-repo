# Class for Puppet classification
class profile::puppet::classifier {

  node_group { 'PE Master':
    ensure => 'present',
    rule   => ['or', ['=', ['trusted', 'extensions', 'pp_role'], 'puppet::cm'], ['=', 'name', $facts['fqdn']]],
  }

  node_group { 'Compile Masters':
    ensure               => 'present',
    classes              => {'role::puppet::cm' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', ['trusted', 'extensions', 'pp_role'], 'puppet::cm'],
  }

  node_group { 'Jenkins Server':
    ensure               => 'present',
    classes              => { 'role::ci' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', ['trusted', 'extensions', 'pp_role'], 'ci'],
  }

  node_group { 'Packages Collection':
    ensure               => 'present',
    classes              => {
      'puppet_enterprise::profile::agent' => {
        'package_inventory_enabled' => true,
      },
    },
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['and', ['~', 'name', '.*']],
  }

  node_group { 'Proxy Server':
    ensure               => 'present',
    classes              => {'role::ci' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', ['trusted', 'extensions', 'pp_role'], 'lb'],
  }

  node_group { 'Puppet Masters':
    ensure               => 'present',
    classes              => {'role::puppet::master' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', 'name', $facts['fqdn']],
  }

  node_group { 'Version Control Server':
    ensure               => 'present',
    classes              => { 'role::vcs' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', ['trusted', 'extensions', 'pp_role'], 'vcs'],
  }

  node_group { 'Bitbucket Server':
    ensure               => 'present',
    classes              => { 'role::bitbucket' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', ['trusted', 'extensions', 'pp_role'], 'bitbucket'],
  }

  node_group { 'vRA Integration':
    ensure               => 'present',
    classes              => {'profile::vra_config' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', 'name', $facts['fqdn']],
  }

  node_group { 'Docker Server':
    ensure               => 'present',
    classes              => { 'role::docker' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['=', ['trusted', 'extensions', 'pp_role'], 'docker'],
  }

  node_group { 'Agents':
    ensure               => 'present',
    classes              => {'profile::base' => {}},
    environment          => 'production',
    override_environment => false,
    parent               => 'All Nodes',
    rule                 => ['~', ['trusted', 'extensions', 'pp_role'], 'agent'],
  }
}
