Facter.add(:external_ip) do
  setcode do
    Facter::Core::Execution.execute('curl http://169.254.169.254/latest/meta-data/public-ipv4', options = {:timeout => 2}).chomp
  end
end
