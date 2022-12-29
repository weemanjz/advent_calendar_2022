require_relative "valve"

@valves = {}
with_pressure = ["AA"]

while (l = gets)
  v, p, *conn = l.scan(/[A-Z]{2}|\d+/)
  @valves[v] = Valve.new(v, p.to_i, conn)
  with_pressure << v if p.to_i > 0
end

@valves.each do |_, v|
  next if v.name == "AA" || v.pressure > 0

  v.connections.each do |c, i|
    v.connections.each do |d, j|
      next if c == d

      @valves[c].add_connection(d, i + j)
    end
    @valves[c].remove_connection(v.name)
  end
end

@distances = {}
with_pressure.each do |v|
  @distances[v] = {}
  with_pressure.each do |v_a|
    @distances[v][v_a] = 1000
  end
  @valves[v].connections.each { |c, i| @distances[v][c] = i }
end

with_pressure.each do |v|
  with_pressure.each do |v_a|
    with_pressure.each do |v_b|
      next if @distances[v_a][v_b] <= @distances[v_a][v] + @distances[v][v_b]
      @distances[v_a][v_b] = @distances[v_a][v] + @distances[v][v_b]
    end
  end
end

@max_pressure = 0

def go(valve, opens, minute, pressure, h)
  return if minute > 30

  v = @valves[valve]
  new_pressure = pressure
  if v.pressure > 0
    new_pressure = pressure + ((30 - minute) * v.pressure)
    h += ["#{minute}: Opens #{valve}"]
    if new_pressure > @max_pressure
      @max_pressure = new_pressure
      @best = h
    end
  end
  @distances[valve].each do |to, dist|
    next if to == valve || to == "AA" || opens.include?(to)

    go(to, opens + [v.name], minute + dist + 1, new_pressure, h)
  end
end

go("AA", [], 0, 0, ["Start AA"])

puts @best.to_s
puts @max_pressure
