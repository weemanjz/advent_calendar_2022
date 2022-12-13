require_relative "map"

map = Map.new

while (l = gets)
  map.add_row(l)
end

map.traverse

puts map.steps
