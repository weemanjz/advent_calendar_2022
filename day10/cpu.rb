class Cpu
  CHECK_STEP = 40

  attr_reader :cycle, :sum

  def initialize
    @cycle = 0
    @x = 1
    @check_at = 20
    @sum = 0
  end

  def exe(cmd)
    @cycle += 1
    check_cycle
    return if cmd == "noop"

    @cycle += 1
    check_cycle
    addx = cmd.split(" ")[1].to_i
    @x += addx
  end

  private

  def check_cycle
    return unless @cycle == @check_at

    @sum += @cycle * @x
    @check_at += CHECK_STEP
    puts "#{@cycle}: x - #{@x}; #{@cycle * @x} - sum - #{@sum}"
  end
end
