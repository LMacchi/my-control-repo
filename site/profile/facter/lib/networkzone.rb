Facter.add(:networkzone) do
  setcode do
    $result = 'internal'
    network = Facter.value(:networking)['interfaces'].each do |iface, values|
      if values['ip'] =~ /172\.16\./
        $result = 'dmz'
      end
    end
    $result
  end
end
