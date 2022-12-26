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

rounds = 1
loop do
  moves = 0
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
        moves += 1
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
  break if moves == 0

  rounds += 1
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

puts rounds
