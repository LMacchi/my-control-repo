# profile/lib/facter/datacenter.rb
Facter.add(:datacenter) do
  setcode do
    fqdn = Facter.value(:fqdn)
    case fqdn
    when /puppetlabs\.vm/
      'puppet'
    else
      'other'
    end
  end
end
