Point = Struct.new("Point", :x, :y)

class Map
  attr_reader :start, :dest, :distances, :min_a

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
    @min_a = @size.x * @size.y
    @distances = Array.new(@size.y) { Array.new(@size.x) }
    check_point(@dest.x, @dest.y, 0, "z")
  end

  def inspect
    distances.map.with_index { |d, y| puts d.map.with_index { |i, x| "#{i}#{@map[y][x]}".rjust(5, " ") }.join }
  end

  private

  def check_point(x, y, dist, h)
    return if x == -1 || y == -1 || x == @size.x || y == @size.y
    return if @distances[y][x] && @distances[y][x] <= dist
    diff = h.ord - @map[y][x].ord
    return if diff > 1

    @distances[y][x] = dist
    if @map[y][x] == "a"
      @min_a = dist if dist < @min_a
      return
    end

    check_point(x - 1, y, dist + 1, @map[y][x])
    check_point(x + 1, y, dist + 1, @map[y][x])
    check_point(x, y - 1, dist + 1, @map[y][x])
    check_point(x, y + 1, dist + 1, @map[y][x])
  end
end
