require 'ipaddr'
Facter.add(:network_zone) do
  confine do
    !Facter.value(:networking)['interfaces'].nil?
  end
  setcode do
    net = 'dmz'
    Facter.value(:networking)['interfaces'].each do |iface, values|
      if IPAddr.new("172.16.0.0/16").include?(values['ip'])
        net = 'internal'
        break # I found the internal ip, don't bother continuing
      else
        next
      end
    end
  net
  end
end
