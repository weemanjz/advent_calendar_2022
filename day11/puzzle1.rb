require_relative "monkey"

ROUNDS = 20

monkeys = []

while l = gets
  puts l
  items = gets.scan(/\d+/).map(&:to_i)
  operation = gets.split(" = ")[1]
  test = gets.scan(/\d+/).first
  on_true = gets.scan(/\d+/).first
  on_false = gets.scan(/\d+/).first
  monkeys << Monkey.new(items, operation, test.to_i, on_true.to_i, on_false.to_i)
  gets
end

ROUNDS.times do
  monkeys.each do |m|
    items = m.turn
    items.each do |item|
      monkeys[item[:to]].items << item[:item]
    end
  end
end

monkeys.each(&:inspect)
