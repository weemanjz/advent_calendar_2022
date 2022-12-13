sum = 0

def prepare_range(range)
  a, b = range.split("-")
  (a..b).to_a
end

while (l = gets)
  l.strip!
  ranges = l.split(",")
  range_1 = prepare_range(ranges[0])
  range_2 = prepare_range(ranges[1])
  common = range_1 & range_2
  sum += 1 unless common.empty?
end

puts sum
