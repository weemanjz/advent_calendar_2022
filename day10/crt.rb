class Crt
  CHECK_STEP = 40

  attr_reader :cycle, :sum

  def initialize
    @cycle = 0
    @x = 1
    @screen = Array.new(6) { Array.new(40) }
  end

  def exe(cmd)
    @cycle += 1
    draw_pixel
    return if cmd == "noop"

    @cycle += 1
    draw_pixel
    addx = cmd.split(" ")[1].to_i
    @x += addx
  end

  def draw
    @screen.each { |r| puts r.join }
  end

  private

  def draw_pixel
    sprite = ((@x - 1)..(@x + 1))
    x = (@cycle - 1) / CHECK_STEP
    y = (@cycle - 1) % CHECK_STEP

    @screen[x][y] = sprite.include?(y) ? "#" : "."
  end
end
