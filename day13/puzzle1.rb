require "json"
require_relative "packet"

sum = 0
i = 1

while (l = gets)
  packet_1 = Packet.new(JSON.parse(l.strip))
  packet_2 = Packet.new(JSON.parse(gets.strip))
  sum += i if packet_1.left?(packet_2)
  i += 1
  gets
end

puts sum
