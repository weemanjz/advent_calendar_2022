POINTS = {"A" => 1, "B" => 2, "C" => 3}

sum = 0

while (l = gets)
  op, strategy = l.strip.split(" ")
  case strategy
  when "X"
    point = POINTS[op] - 1
    sum += point == 0 ? 3 : point
  when "Y"
    sum += 3
    sum += POINTS[op]
  when "Z"
    sum += 6
    point = POINTS[op] + 1
    sum += point == 4 ? 1 : point
  end
end

puts sum
