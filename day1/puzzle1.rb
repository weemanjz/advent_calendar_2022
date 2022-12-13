max = 0
sum = 0

while (l = gets)
  if l.strip.empty?
    max = sum if sum > max
    sum = 0
  end
  sum += l.to_i
end

max = sum if sum > max

puts max
