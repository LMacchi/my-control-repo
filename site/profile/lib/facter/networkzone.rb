require "ipaddr"
Facter.add(:networkzone) do
  setcode do
    result = 'dmz'
    network = Facter.value(:networking)['interfaces'].each do |iface, values|
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
