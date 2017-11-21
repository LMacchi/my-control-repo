require 'ipaddr'
Facter.add(:network_zone) do
  setcode do
    # Exit with 'none' if there is no networking fact
    return 'none' unless !Facter.value(:networking).nil?
    result = 'dmz'
    Facter.value(:networking)['interfaces'].each do |iface, values|
      if IPAddr.new("172.16.0.0/16").include?(values['ip'])
        result = 'internal'
        break # I found the internal ip, don't bother continuing
      else
        next
      end
    end
  result
  end
end
