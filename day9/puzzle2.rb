require_relative "rope"

rope = Rope.new(10)

while (l = gets)
  l.strip!
  move, steps = l.split(" ")
  case move
  when "U"
    rope.up(steps.to_i)
  when "D"
    rope.down(steps.to_i)
  when "R"
    rope.right(steps.to_i)
  when "L"
    rope.left(steps.to_i)
  end
end

puts rope.tail_positions.size
