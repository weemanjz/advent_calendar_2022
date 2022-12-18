require_relative "point"

class Rock
  attr_reader :points

  def initialize(points)
    @points = points.map { |p| Point.new(p[0], p[1]) }
  end
end
