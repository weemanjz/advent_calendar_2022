require "set"
require_relative "sensor"

ROW_TO_CHECK = 4000000

sensors = []
beacons = Set.new

while (l = gets)
  s_x, s_y, b_x, b_y = l.scan(/-?\d+/).map(&:to_i)
  sens = Sensor.new(s_x, s_y)
  sens.closest_beacon(b_x, b_y)
  sensors << sens
  beacons.add({x: b_x, y: b_y})
end

all = {}

(0..ROW_TO_CHECK).each do |i|
  signals = sensors.map { |s| s.signal_at_row(i) }.compact.sort

  curr = signals.shift
  ranges = []

  while !signals.empty?
    tmp = signals.shift
    if tmp[0] <= curr[1] + 1
      curr = [curr[0], (tmp[1] > curr[1]) ? tmp[1] : curr[1]]
    else
      ranges << curr
      curr = tmp
    end
  end

  ranges << curr

  ranges.reject! { |r| r[0] <= 0 && r[1] >= ROW_TO_CHECK }

  all[i] = ranges if !ranges.empty?
end

puts all.to_s

y = all.keys.first
x = all.values.first[0][1] + 1

puts x * 4000000 + y
