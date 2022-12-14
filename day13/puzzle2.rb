require "json"
require_relative "packet"

packets = [Packet.new([[2]]), Packet.new([[6]])]

while (l = gets)
  packets << Packet.new(JSON.parse(l.strip))
  packets << Packet.new(JSON.parse(gets.strip))
  gets
end

sorted = packets.sort { |x, y| x.left?(y) ? -1 : 1 }.map(&:packet)

a = sorted.index([[2]]) + 1
b = sorted.index([[6]]) + 1

puts a, b
