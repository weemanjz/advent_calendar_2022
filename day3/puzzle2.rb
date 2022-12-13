sum = 0
i = 0
badge = []

while (l = gets)
  l.strip!
  i += 1
  badge = l.chars if i == 1
  badge &= l.chars
  next unless i == 3

  i = 0
  same = badge.first
  if ("a".."z").include?(same)
    sum += same.ord - "a".ord + 1
  else
    sum += same.ord - "A".ord + 27
  end
end

puts sum
