MARKER_LENGTH = 14

chars = {}
("a".."z").each { |c| chars[c] = 0 }

repeated = 0
i = 0
input = gets
while repeated > 0 || i < MARKER_LENGTH
  chars[input[i]] += 1
  repeated += 1 if chars[input[i]] > 1
  last = i - MARKER_LENGTH
  i += 1
  next if last < 0

  repeated -= 1 if chars[input[last]] > 1
  chars[input[last]] -= 1
end

puts i
