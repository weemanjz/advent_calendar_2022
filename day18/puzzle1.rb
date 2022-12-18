@cubes = {}

def insert_cube(x, y, z)
  @cubes[x] ||= {}
  @cubes[x][y] ||= {}
  @cubes[x][y][z] = true
end

while (l = gets)
  x, y, z = l.scan(/\d+/).map(&:to_i)
  insert_cube(x, y, z)
end

count = 0

@cubes.each do |x, ys|
  ys.each do |y, zs|
    zs.each do |z, _|
      count += 1 unless @cubes.dig(x + 1, y, z)
      count += 1 unless @cubes.dig(x - 1, y, z)
      count += 1 unless @cubes.dig(x, y + 1, z)
      count += 1 unless @cubes.dig(x, y - 1, z)
      count += 1 unless @cubes.dig(x, y, z + 1)
      count += 1 unless @cubes.dig(x, y, z - 1)
    end
  end
end

puts count
