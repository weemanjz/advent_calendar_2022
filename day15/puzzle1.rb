require "set"
require_relative "sensor"

ROW_TO_CHECK = 2000000

sensors = []
beacons = Set.new

while (l = gets)
  s_x, s_y, b_x, b_y = l.scan(/-?\d+/).map(&:to_i)
  sens = Sensor.new(s_x, s_y)
  sens.closest_beacon(b_x, b_y)
  sensors << sens
  beacons.add({x: b_x, y: b_y})
end

signals = sensors.map { |s| s.signal_at_row(ROW_TO_CHECK) }.compact.sort

curr = signals.shift
ranges = []

while !signals.empty?
  tmp = signals.shift
  if tmp[0] <= curr[1]
    curr = [curr[0], (tmp[1] > curr[1]) ? tmp[1] : curr[1]]
  else
    ranges << curr
    curr = tmp
  end
end

ranges << curr

beacons_at_row = beacons.select { |b| b[:y] == ROW_TO_CHECK }.map { |b| b[:x] }.sort

count = ranges.reduce(0) { |s, r| s + (r[1] - r[0] + 1) }
ranges.each do |r|
  beacons_at_row.shift while !beacons_at_row.empty? && beacons_at_row.first < r[0]

  while !beacons_at_row.empty? && beacons_at_row.first <= r[1]
    beacons_at_row.shift
    count -= 1
  end
end

puts count
