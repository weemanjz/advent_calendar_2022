require_relative "rock_position"

class RockFalling
  def initialize(chamber, rocks, jets, rocks_count)
    @chamber = chamber
    @rocks = rocks
    @jets = jets
    @rocks_count = rocks_count
  end

  def simulate
    jet_i = 0
    @rocks_count.times do |i|
      pos = RockPosition.new(@rocks[i % @rocks.size], 2, @chamber.height + 3)
      loop do
        jet = @jets[jet_i]
        jet_i = (jet_i + 1) % @jets.length
        if jet == ">"
          pos.move_right if @chamber.right?(pos)
        elsif jet == "<"
          pos.move_left if @chamber.left?(pos)
        end
        break unless @chamber.down?(pos)
        pos.move_down
      end
      @chamber.place_rock(pos)
    end
    @chamber.height
  end
end
