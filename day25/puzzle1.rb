require_relative "snafu"

numbers = []

while (l = gets)
  numbers << Snafu.new(l.strip)
end

puts numbers.reduce(:+)
