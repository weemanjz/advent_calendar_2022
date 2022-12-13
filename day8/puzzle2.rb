require_relative "map2"

map = Map2.new

while (l = gets)
  heights = l.scan(/\d/).map(&:to_i)
  map.add_row(heights)
end

puts map.top_scenic_score
