calories = []
sum = 0

while (l = gets)
  if l.strip.empty?
    calories << sum
    sum = 0
  end
  sum += l.to_i
end

calories << sum

top_3 = calories.sort.last(3)

puts top_3.reduce(:+)
