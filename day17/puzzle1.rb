require_relative "chamber"
require_relative "rock"
require_relative "rock_falling"
require "pry"

class Puzzle1
  def call
    jets = gets.strip

    rocks = [
      Rock.new([[0, 0], [1, 0], [2, 0], [3, 0]]),
      Rock.new([[0, 1], [1, 0], [1, 1], [1, 2], [2, 1]]),
      Rock.new([[0, 0], [1, 0], [2, 0], [2, 1], [2, 2]]),
      Rock.new([[0, 0], [0, 1], [0, 2], [0, 3]]),
      Rock.new([[0, 0], [1, 0], [0, 1], [1, 1]])
    ]
    chamber = Chamber.new
    falling = RockFalling.new(chamber, rocks, jets, 2022)

    puts falling.simulate - 1
  end
end

Puzzle1.new.call
