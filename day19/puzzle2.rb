REGEX = /Each (\w+) robot costs (\d+ \w+)(?: and (\d+ \w+))*/
@bp = {}

while (l = gets)
  id = l.scan(/\d+/).first.to_i
  r = 4.times.map { gets.match(REGEX) }
  @bp[id] = r.reverse.to_h do |a|
    cost = a[2..].compact.to_h { |c| c.split(" ").reverse }.transform_values(&:to_i)
    [a[1], cost]
  end
  gets
end

result = 1
@bp.each do |id, bp|
  break if id > 3
  @max_geodes = 0
  max_costs = {"ore" => 0, "clay" => 0, "obsidian" => 0, "geode" => 32}
  bp.each do |_, costs|
    costs.each { |r, c| max_costs[r] = c if c > max_costs[r] }
  end
  q = [[0, ["ore"], {"ore" => 0, "clay" => 0, "obsidian" => 0, "geode" => 0}]]

  while !q.empty?
    min, robots, res = q.pop
    rt = robots.tally
    if rt["geode"]
      geodes_count = res["geode"] + (rt["geode"] * (32 - min))
      @max_geodes = geodes_count if geodes_count > @max_geodes
    end

    bp.each do |r, cost|
      next if rt.fetch(r, 0) == max_costs[r]
      next unless cost.all? { |r, _| rt.key?(r) }

      minutes = 0
      cost.each do |r, c|
        missing = c - res[r]
        x = missing / rt[r]
        x += 1 if (missing % rt[r]) > 0
        minutes = x if x > minutes
      end
      new_min = min + minutes + 1
      next if new_min > 32

      res_copy = res.dup
      rt.each { |r, c| res_copy[r] += c * (minutes + 1) }
      cost.each { |r, no| res_copy[r] -= no }
      q << [new_min, robots + [r], res_copy]
    end
  end

  puts "#{id}: #{@max_geodes}"
  result *= @max_geodes
end

puts result
