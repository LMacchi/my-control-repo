Facter.add(:datacenter) do
  setcode do
    fqdn = Facter.value(:fqdn)
    case fqdn
    when /puppetlabs\.vm/i
      "puppet"
    else
      "external"
    end
  end
end
