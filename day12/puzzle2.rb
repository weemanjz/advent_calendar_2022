require_relative "map2"

map = Map.new

while (l = gets)
  map.add_row(l)
end

map.traverse

puts map.min_a
