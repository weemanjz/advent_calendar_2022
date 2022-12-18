class Chamber
  WIDE = 7

  attr_reader :height

  def initialize
    @map = ["#" * WIDE]
    @height = 1
  end

  def right?(pos)
    return false if pos.right + 1 == WIDE

    fill_map(pos.top)
    pos.points.all? { |p| @map[p.y][p.x + 1] == " " }
  end

  def left?(pos)
    return false if pos.left == 0

    fill_map(pos.top)
    pos.points.all? { |p| @map[p.y][p.x - 1] == " " }
  end

  def down?(pos)
    return true if pos.down > height + 1

    pos.points.all? { |p| @map[p.y - 1][p.x] == " " }
  end

  def place_rock(pos)
    pos.points.each { |p| @map[p.y][p.x] = "#" }
    @height = pos.top + 1 if pos.top + 1 > height
  end

  def to_s
    (@map.size - 1).downto(0) { |i| puts "|#{@map[i]}|" }
    puts "+-------+"
  end

  private

  def fill_map(h)
    (h - @map.size + 1).times { @map << " " * WIDE }
  end
end
