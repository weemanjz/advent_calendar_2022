require_relative "monkey2"

ROUNDS = 10000

monkeys = []
mcf = 1

while gets
  items = gets.scan(/\d+/).map(&:to_i)
  operation = gets.split(" = ")[1]
  test = gets.scan(/\d+/).first
  mcf *= test.to_i
  on_true = gets.scan(/\d+/).first
  on_false = gets.scan(/\d+/).first
  monkeys << Monkey.new(items, operation, test.to_i, on_true.to_i, on_false.to_i)
  gets
end

ROUNDS.times do |i|
  monkeys.each do |m|
    items = m.turn
    items.each do |item|
      monkeys[item[:to]].items << item[:item] % mcf
    end
  end
end

totals = monkeys.map(&:total).sort
most = totals.last(2)

puts most[0] * most[1]
