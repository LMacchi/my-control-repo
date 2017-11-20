Facter.add("mynilfact") do
  setcode do
    {"foo" => "\u0000"}
  end
end
