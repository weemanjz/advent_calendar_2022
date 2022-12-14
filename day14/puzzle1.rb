require_relative "cave"

lines = []

while (l = gets)
  lines << l.strip.split(" -> ").map { |p| p.split(",").map(&:to_i) }
end

cave = Cave.new(lines)
puts cave.pour_sand
