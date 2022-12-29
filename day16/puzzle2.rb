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

def go(valve_a, valve_b, opens, minute_a, minute_b, pressure, h)
  return if minute_a >= 26 && minute_b >= 26

  v_a = @valves[valve_a]
  v_b = @valves[valve_b]
  new_pressure = pressure
  if v_a.pressure > 0
    if minute_a < 26
      new_pressure = pressure + ((26 - minute_a) * v_a.pressure)
      # h = h + ["A#{minute_a}: opens #{valve_a}"]
    end
    if minute_b < 26
      new_pressure = new_pressure + ((26 - minute_b) * v_b.pressure)
      # h = h + ["B#{minute_b}: opens #{valve_b}"]
    end
    if new_pressure > @max_pressure
      @max_pressure = new_pressure
      @best = h
    end
  end
  any_a = false
  any_b = false
  @distances[valve_a].each do |to_a, dist_a|
    next if to_a == valve_a || to_a == "AA" || opens.include?(to_a) || (minute_a + dist_a + 1) >= 26
    any_a = true
    @distances[valve_b].each do |to_b, dist_b|
      next if to_b == valve_b || to_a == to_b || to_b == "AA" || opens.include?(to_b) || (minute_b + dist_b + 1) >= 26
      any_b = true
      go(to_a, to_b, opens + [to_a, to_b], minute_a + dist_a + 1, minute_b + dist_b + 1, new_pressure, h)
    end
    unless any_b
      go(to_a, valve_b, opens + [to_a], minute_a + dist_a + 1, 26, new_pressure, h)
    end
  end
  return if any_a
  @distances[valve_b].each do |to_b, dist_b|
    next if to_b == valve_b || to_b == "AA" || opens.include?(to_b) || (minute_b + dist_b + 1) >= 26
    any_b = true
    go(valve_a, to_b, opens + [to_b], 26, minute_b + dist_b + 1, new_pressure, h)
  end
end

go("AA", "AA", [], 0, 0, 0, ["Start AA"])

puts @best.to_s
puts @max_pressure
