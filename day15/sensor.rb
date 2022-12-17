class Sensor
  def initialize(x, y)
    @x = x
    @y = y
  end

  def closest_beacon(x, y)
    @beacon_dist = (@x - x).abs + (@y - y).abs
  end

  def signal_at_row(y)
    dist = (@y - y).abs
    return nil if dist > @beacon_dist

    diff = @beacon_dist - dist
    [@x - diff, @x + diff]
  end
end
