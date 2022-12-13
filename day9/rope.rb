require "set"

Position = Struct.new("Position", :x, :y)

class Rope
  attr_reader :tail_positions, :knots

  def initialize(knots)
    @knots = Array.new(knots) { Position.new(0, 0) }
    @tail_positions = Set.new
    add_tail_position
  end

  def up(steps)
    steps.times do
      knots[0].y += 1
      adjust
    end
  end

  def down(steps)
    steps.times do
      knots[0].y -= 1
      adjust
    end
  end

  def left(steps)
    steps.times do
      knots[0].x -= 1
      adjust
    end
  end

  def right(steps)
    steps.times do
      knots[0].x += 1
      adjust
    end
  end

  private

  def adjust
    (1...knots.size).each do |i|
      break unless (knots[i - 1].y - knots[i].y).abs > 1 || (knots[i - 1].x - knots[i].x).abs > 1

      x_diff = knots[i - 1].x - knots[i].x
      y_diff = knots[i - 1].y - knots[i].y
      if x_diff != 0 && y_diff != 0
        knots[i].y += (y_diff > 0 ? 1 : -1)
        knots[i].x += (x_diff > 0 ? 1 : -1)
      elsif x_diff.abs > 1
        knots[i].x += (x_diff > 0 ? 1 : -1)
      else
        knots[i].y += (y_diff > 0 ? 1 : -1)
      end
    end
    add_tail_position
  end

  def add_tail_position
    tail_positions.add("#{tail.x}:#{tail.y}")
  end

  def tail
    knots.last
  end
end
