class Snafu
  def initialize(number)
    @number = number
  end

  def to_i
    int_value
  end

  def self.parse(int)
    return new("0") if int == 0

    s = ""
    while int > 0
      r = int % 5
      int /= 5
      case r
      when 0, 1, 2
        s = "#{r}#{s}"
      when 3
        s = "=#{s}"
        int += 1
      when 4
        s = "-#{s}"
        int += 1
      end
    end
    new(s)
  end

  def +(number)
    new_val = to_i + number.to_i
    self.class.parse(new_val)
  end

  def ==(snafu)
    to_s == snafu.to_s
  end

  def to_s
    @number
  end

  def inspect
    to_s
  end

  private

  def int_value
    @int_value ||= \
      @number.chars.reduce(0) do |int, c|
        int *= 5
        case c
        when "0", "1", "2"
          int + c.to_i
        when "-"
          int - 1
        when "="
          int - 2
        end
      end
  end
end
