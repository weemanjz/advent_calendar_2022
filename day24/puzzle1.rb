require_relative "map"

map = []

while (l = gets)
  map << l.strip
end

m = Map.new(map)

puts m.escape
