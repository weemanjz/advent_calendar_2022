OPP = {"+" => "-", "-" => "+", "*" => "/" , "/" => "*"}
@monkeys = {}

while (l = gets)
  l.strip!
  monk, r = l.split(": ")
  @monkeys[monk] = r.match?(/\d+/) ? r.to_i : r.split(" ")
end

def path(find, p)
  return if @monkeys[p.last].is_a?(Integer)
  return p if @monkeys[p.last][0] == find || @monkeys[p.last][2] == find
  path(find, p + [@monkeys[p.last][0]]) || path(find, p + [@monkeys[p.last][2]])
end

n = 0
if (p = path("humn", [@monkeys["root"][0]]))
  n = 2
  q = [@monkeys["root"][2]]
else
  p = path("humn", [@monkeys["root"][2]])
  q = [@monkeys["root"][0]]
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

def calculate(q)
  while !q.empty?
    m = q.pop
    a, op, b = @monkeys[m]
    if @monkeys[a].is_a?(Integer) && @monkeys[b].is_a?(Integer)
      @monkeys[m] = math(@monkeys[a], op, @monkeys[b])
    else
      q << m
      q << a unless @monkeys[a].is_a?(Integer)
      q << b unless @monkeys[b].is_a?(Integer)
    end
  end
end

calculate(q)

prev = "humn"
while !p.empty?
  m = p.pop
  if @monkeys[m][0] == prev
    @monkeys[prev] = [m, OPP[@monkeys[m][1]], @monkeys[m][2]]
  elsif ["+", "*"].include?(@monkeys[m][1])
    @monkeys[prev] = [m, OPP[@monkeys[m][1]], @monkeys[m][0]]
  else
    @monkeys[prev] = [@monkeys[m][0], @monkeys[m][1], m]
  end
  prev = m
end

@monkeys[prev] = @monkeys[@monkeys["root"][n]]

calculate(["humn"])

puts @monkeys["humn"]
