# profile/manifests/puppet/master.pp
class profile::puppet::master {

  # Configure global hiera
  class { '::hiera':
    hiera_version   =>  '5',
    hiera5_defaults => { 'datadir' => 'data', 'data_hash' => 'yaml_data' },
    eyaml           => true,
    cmdpath         => ['/opt/puppetlabs/puppet/lib/ruby/vendor_gems/bin','/opt/puppetlabs/puppet/bin',$facts['path']],
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
