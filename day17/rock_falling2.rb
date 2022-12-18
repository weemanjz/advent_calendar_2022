require "set"
require_relative "rock_position"

class RockFalling
  def initialize(chamber, rocks, jets, rocks_count)
    @chamber = chamber
    @rocks = rocks
    @jets = jets
    @rocks_count = rocks_count
    @cycle = []
  end

  def simulate
    existing = Set.new
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
      prev_h = @chamber.height
      @chamber.place_rock(pos)
      pair = [jet_i, i % @rocks.size]
      if existing.include?(pair)
        if !@cycle.empty?
          if @cycle.last[:i] == i - 1
            break if @cycle.first[:jet] == pair[0] && @cycle.first[:rock] == pair[1]
          else
            @cycle = []
          end
        end
        @cycle << {jet: jet_i, i: i, rock: i % @rocks.size, h: @chamber.height, prev_h: prev_h}
      else
        existing.add(pair)
      end
    end
    calculate_height
  end

  private

  def calculate_height
    cycle_h = @cycle.last[:h] - @cycle.first[:h]
    cycle_length = @cycle.size
    cycles_count = (@rocks_count - @cycle.first[:i]) / cycle_length
    rest_rocks = (@rocks_count - @cycle.first[:i]) % cycle_length
    cycle_h * cycles_count + @cycle[rest_rocks - 1][:h]
  end
end
