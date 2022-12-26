require "set"
require "pry"

Position = Struct.new("Position", :i, :j, :min)

class Map
  DIRS = [[-1, 0], [0, -1], [1, 0], [0 ,1], [0, 0]]

  attr_reader :map, :start, :fin, :len, :h, :visited

  def initialize(map)
    @map = map
    @start = Position.new(0, @map[0].index("."), 0)
    @fin = Position.new(@map.length - 1, @map.last.index("."), nil)
    @len = @map.first.length - 2
    @h = @map.size - 2
    @visited = Set.new
  end

  def escape
    q = [Position.new(start.i, start.j, 0)]
    end_min = nil
    loop do
      p = q.shift
      DIRS.each do |a, b|
        ni = p.i + a
        nj = p.j + b
        if ni == fin.i && nj == fin.j
          end_min = p.min + 1
          break
        end
        next if border?(ni, nj) || visited.include?([ni, nj, p.min + 1]) || blizzard?(ni, nj, p.min + 1)

        visited.add([ni, nj, p.min + 1])
        q << Position.new(ni, nj, p.min + 1)
      end
      break if end_min
    end
    end_min
  end

  private

  def border?(i, j)
    return false if i == start.i && j == start.j
    i < 1 || j < 1 || i > h || j > len
  end

  def blizzard?(i, j, min)
    return false if i == start.i && j == start.j

    left = j - min
    left += len while left < 1
    return true if map[i][left] == ">"

    right = j + min
    right -= len while right > len
    return true if map[i][right] == "<"

    up = i - min
    up += h while up < 1
    return true if map[up][j] == "v"

    down = i + min
    down -= h while down > h
    return true if map[down][j] == "^"

    false
  end
end
