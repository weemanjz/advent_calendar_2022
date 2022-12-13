POINTS = {"X" => 1, "Y" => 2, "Z" => 3}
WIN = {"X" => "C", "Y" => "A", "Z" => "B"}

sum = 0

while (l = gets)
  op, me = l.strip.split(" ")
  sum += POINTS[me]
  sum += 6 if WIN[me] == op
  sum += 3 if me.ord - op.ord == 23
end

puts sum
