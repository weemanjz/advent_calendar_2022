class Cave
  def initialize(rock_lines)
    @max_y = 0
    build_map(rock_lines)
  end

  def pour_sand
    sands = 0
    loop do
      x, y = 500, 0
      loop do
        if empty?(x, y + 1)
          y += 1
        elsif empty?(x - 1, y + 1)
          x -= 1
          y += 1
        elsif empty?(x + 1, y + 1)
          x += 1
          y += 1
        else
          @map[y][x] = "o"
          sands += 1
          break
        end
      end
      break if x == 500 && y == 0
    end
    sands
  end

  def to_s
    @map.each { |r| puts r.join }
  end

  private

  def empty?(x, y)
    @map[y][x] == "."
  end

  def build_map(lines)
    lines.each do |points|
      points.each do |x, y|
        @max_y = y if y > @max_y
      end
    end
    lines << [[0, @max_y + 2], [1000, @max_y + 2]]
    @map = Array.new(@max_y + 3) { Array.new(1001, ".") }
    lines.each do |points|
      points.each_cons(2) { |a, b| build_line(a, b) }
    end
  end

  def build_line(p1, p2)
    if p1[0] == p2[0]
      a, b = (p1[1] > p2[1]) ? [p2[1], p1[1]] : [p1[1], p2[1]]
      a.upto(b) { |y| @map[y][p1[0]] = "#" }
    else
      a, b = (p1[0] > p2[0]) ? [p2[0], p1[0]] : [p1[0], p2[0]]
      a.upto(b) { |x| @map[p1[1]][x] = "#" }
    end
  end
end
