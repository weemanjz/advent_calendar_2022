Point = Struct.new("Point", :x, :y)

class Map
  attr_reader :start, :dest, :distances

  def initialize
    @map = []
  end

  def add_row(row)
    @map << row
    start_index = row.index("S")
    end_index = row.index("E")
    if start_index
      @start = Point.new(start_index, @map.size - 1)
      row[start_index] = "a"
    end
    if end_index
      @dest = Point.new(end_index, @map.size - 1)
      row[end_index] = "z"
    end
  end

  def traverse
    @size = Point.new(@map[0].size, @map.size)
    @distances = Array.new(@size.y) { Array.new(@size.x) }
    check_point(@start.x, @start.y, 0, "a")
  end

  def steps
    distances[dest.y][dest.x]
  end

  def inspect
    distances.map.with_index { |d, y| puts d.map.with_index { |i, x| "#{i}#{@map[y][x]}".rjust(5, " ") }.join() }
  end

  private

  def check_point(x, y, dist, h)
    return if x == -1 || y == -1 || x == @size.x || y == @size.y
    return if @distances[y][x] && @distances[y][x] <= dist
    diff = @map[y][x].ord - h.ord
    return if diff > 1

    @distances[y][x] = dist
    return if y == dest.y && x == dest.x

    check_point(x - 1, y, dist + 1, @map[y][x])
    check_point(x + 1, y, dist + 1, @map[y][x])
    check_point(x, y - 1, dist + 1, @map[y][x])
    check_point(x, y + 1, dist + 1, @map[y][x])
  end
end
