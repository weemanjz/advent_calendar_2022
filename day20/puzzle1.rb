require "pry"
require_relative "list"

list = List.new
pointers = []

while (l = gets)
  pointers << list.append(l.to_i)
end

pointers.each do |p|
  list.move(p)
end

zero = pointers.find { |p| p.val == 0 }

puts zero.find(1000) + zero.find(2000) + zero.find(3000)
