Facter.add('default_gateway') do
  confine :kernel => 'Linux'
  setcode do
    Facter::Core::Execution.exec('ip route | grep default | awk \'{print $3}\'')
  end
end
