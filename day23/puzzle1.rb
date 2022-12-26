require "set"

elves = Set.new

y = 0
while (l = gets)
  x = -1
  elves.add([x, y]) while (x = l.index("#", x + 1))
  y += 1
end
directions = [
  {dir: [[-1, -1], [0, -1], [1, -1]], move: [0, -1] },
  {dir: [[-1, 1], [0, 1], [1, 1]], move: [0, 1] },
  {dir: [[-1, -1], [-1, 0], [-1, 1]], move: [-1, 0] },
  {dir: [[1, -1], [1, 0], [1, 1]], move: [1, 0] }
]

10.times do
  new_pos = {}
  elv_pos = elves.to_a
  elv_pos.each_with_index do |e, i|
    n = {}
    n[[-1, -1]] = elves.include?([e[0] - 1, e[1] - 1])
    n[[0, -1]] = elves.include?([e[0], e[1] - 1])
    n[[1, -1]] = elves.include?([e[0] + 1, e[1] - 1])
    n[[-1, 0]] = elves.include?([e[0] - 1, e[1]])
    n[[1, 0]] = elves.include?([e[0] + 1, e[1]])
    n[[-1, 1]] = elves.include?([e[0] - 1, e[1] + 1])
    n[[0, 1]] = elves.include?([e[0], e[1] + 1])
    n[[1, 1]] = elves.include?([e[0] + 1, e[1] + 1])
    if n.values.all? { |v| v == false }
      new_pos[e] ||= []
      new_pos[e] << i
      next
    end

    a = false
    directions.each do |dir|
      if dir[:dir].all? { |d| !n[d] }
        a = true
        p = [e[0] + dir[:move][0], e[1] + dir[:move][1]]
        new_pos[p] ||= []
        new_pos[p] << i
        break
      end
    end
    next if a
    new_pos[e] ||= []
    new_pos[e] << i
  end
  elves = Set.new
  new_pos.each do |pos, e|
    if e.size == 1
      elves.add(pos)
      next
    end
    e.each { |x| elves.add(elv_pos[x]) }
  end
  dir = directions.shift
  directions << dir
end

f = elves.first
borders = {x_min: f[0], x_max: f[0], y_min: f[1], y_max: f[1]}
elves.each do |e|
  borders[:x_min] = e[0] if borders[:x_min] > e[0]
  borders[:x_max] = e[0] if borders[:x_max] < e[0]
  borders[:y_min] = e[1] if borders[:y_min] > e[1]
  borders[:y_max] = e[1] if borders[:y_max] < e[1]
end

a = (borders[:x_max] - borders[:x_min] + 1) * (borders[:y_max] - borders[:y_min] + 1)

puts a - elves.size
