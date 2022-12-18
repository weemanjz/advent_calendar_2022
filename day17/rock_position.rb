require_relative "point"

class RockPosition
  attr_reader :left, :right, :down, :top, :points

  def initialize(rock, x, y)
    @points = rock.points.map { |p| Point.new(p.x + x, p.y + y) }
    @left = x
    @down = y
    @right = @points.max { |a, b| a.x <=> b.x }.x
    @top = @points.max { |a, b| a.y <=> b.y }.y
  end

  def move_right
    points.each { |p| p.x += 1 }
    @right += 1
    @left += 1
  end

  def move_left
    points.each { |p| p.x -= 1 }
    @right -= 1
    @left -= 1
  end

  def move_down
    points.each { |p| p.y -= 1 }
    @down -= 1
    @top -= 1
  end
end
