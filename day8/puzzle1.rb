require_relative "map"

map = Map.new

while (l = gets)
  heights = l.scan(/\d/).map(&:to_i)
  map.add_row(heights)
end

map.calculate_max_heights
puts map.visible_trees_count
