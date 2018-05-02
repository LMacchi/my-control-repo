# profile/manifests/puppet/master.pp
class profile::puppet::master {

  # Hiera class does not seem to install the eyaml binary
  package { 'eyaml_cli':
    ensure   => present,
    name     => 'hiera-eyaml',
    provider => 'puppet_gem',
    before   => Class['hiera'],
  }

  # Configure global hiera
  class { '::hiera':
    hiera_version   =>  '5',
    hiera5_defaults => { 'datadir' => 'data', 'data_hash' => 'yaml_data' },
    eyaml           => true,
    create_keys     => true,
    hierarchy       => [
      {
        'name'       => 'Secrets',
        'path'       => 'secrets.eyaml',
        'lookup_key' => 'eyaml_lookup_key',
      },
      {
        'name'  => 'Nodes yaml',
        'paths' => ['nodes/%{trusted.certname}.yaml', 'nodes/%{facts.datacenter}.yaml'],
      },
      {
        'name' => 'Default yaml file',
        'path' =>  'common.yaml',
      },
    ],
  }
}
