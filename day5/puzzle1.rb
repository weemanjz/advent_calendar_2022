stacks = []

while (l = gets)
  break if l.start_with?(" 1 ")

  crates = l.scan(/(\s{3}|\[[A-Z]\])\s/)
    .flatten
    .map { |cr| cr.strip.delete("[]") }

  crates.each.with_index do |cr, i|
    stacks[i] ||= []
    next if cr.empty?

    stacks[i].unshift(cr)
  end
end

gets

while (l = gets)
  number, from, to = l.scan(/\d+/).map(&:to_i)
  crates = stacks[from - 1].pop(number)
  stacks[to - 1] += crates.reverse
end

puts stacks.map(&:last).join
