sum = 0

while (l = gets)
  l.strip!
  size = l.length
  part1 = l[0...size/2].chars
  part2 = l[size/2..].chars
  same = (part1 & part2).first
  if ("a".."z").include?(same)
    sum += same.ord - "a".ord + 1
  else
    sum += same.ord - "A".ord + 27
  end
end

puts sum
