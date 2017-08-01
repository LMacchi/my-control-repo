Facter.add('default_interface') do
  confine :kernel => 'Linux'
  setcode do
    Facter::Core::Execution.exec('ip route | grep default | awk \'{print $NF}\'')
  end
end
