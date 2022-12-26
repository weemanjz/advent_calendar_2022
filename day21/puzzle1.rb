monkeys = {}

while (l = gets)
  l.strip!
  monk, r = l.split(": ")
  monkeys[monk] = r.match?(/\d+/) ? r.to_i : r.split(" ")
end

def math(a, op, b)
  case op
  when "+"
    a + b
  when "-"
    a - b
  when "/"
    a / b
  when "*"
    a * b
  end
end

q = ["root"]

while !q.empty?
  m = q.pop
  a, op, b = monkeys[m]
  if monkeys[a].is_a?(Integer) && monkeys[b].is_a?(Integer)
    monkeys[m] = math(monkeys[a], op, monkeys[b])
  else
    q << m
    q << a unless monkeys[a].is_a?(Integer)
    q << b unless monkeys[b].is_a?(Integer)
  end
end

puts monkeys["root"]
