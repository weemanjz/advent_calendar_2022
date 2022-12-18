@max_x = 0
@max_y = 0
@max_z = 0
cubes = []

while (l = gets)
  x, y, z = l.scan(/\d+/).map(&:to_i)
  @max_x = x if x > @max_x
  @max_y = y if y > @max_y
  @max_z = z if z > @max_z
  cubes << [x, y, z]
end

@m = Array.new(@max_x + 1) { Array.new(@max_y + 1) { Array.new(@max_z + 1, -1) } }

cubes.each { |x, y, z| @m[x][y][z] = 0 }
@to_check = []

def check_if_external(x, y, z)
  return if @m.dig(x, y, z) == 0
  if x == 0 || x == @max_x || y == 0 || y == @max_y || z == 0 || z == @max_z
    @m[x][y][z] = 1
    return
  end
  if @m.dig(x - 1, y, z) == 1 || @m.dig(x, y - 1, z) == 1 || @m.dig(x, y, z - 1) == 1
    @m[x][y][z] = 1
    return
  end
  @to_check << [x, y, z]
end

0.upto(@max_x) do |x|
  0.upto(@max_y) do |y|
    0.upto(@max_z) do |z|
      check_if_external(x, y, z)
    end
  end
end

loop do
  tmp = @to_check
  @to_check = []
  tmp.each do |x, y, z|
    if @m.dig(x - 1, y, z) == 1 || @m.dig(x, y - 1, z) == 1 || @m.dig(x, y, z - 1) == 1
      @m[x][y][z] = 1
      next
    end
    if @m.dig(x + 1, y, z) == 1 || @m.dig(x, y + 1, z) == 1 || @m.dig(x, y, z + 1) == 1
      @m[x][y][z] = 1
      next
    end
    @to_check << [x, y, z]
  end
  break if tmp == @to_check
end

count = 0
cubes.each do |x, y, z|
  count += 1 if @m.dig(x + 1, y, z).nil? || @m.dig(x + 1, y, z) == 1
  count += 1 if @m.dig(x - 1, y, z).nil? || @m.dig(x - 1, y, z) == 1
  count += 1 if @m.dig(x, y + 1, z).nil? || @m.dig(x, y + 1, z) == 1
  count += 1 if @m.dig(x, y - 1, z).nil? || @m.dig(x, y - 1, z) == 1
  count += 1 if @m.dig(x, y, z + 1).nil? || @m.dig(x, y, z + 1) == 1
  count += 1 if @m.dig(x, y, z - 1).nil? || @m.dig(x, y, z - 1) == 1
end

puts count
