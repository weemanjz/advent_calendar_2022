class Packet
  class WrongOrderError < StandardError; end

  attr_reader :packet

  def initialize(packet)
    @packet = packet
  end

  def left?(right)
    compare(packet, right.packet)
    true
  rescue WrongOrderError
    false
  end

  private

  def compare(l, r)
    if l.is_a?(Integer) && r.is_a?(Integer)
      return true if l < r
      raise WrongOrderError, "#{l} - #{r}" if l > r
    elsif l.is_a?(Array) && r.is_a?(Array)
      return false if l == r

      l.each.with_index do |a, i|
        raise WrongOrderError, "#{l} - #{r}" if r[i].nil?
        break if compare(a, r[i])
      end
      return true
    elsif compare([*l], [*r])
      return true
    end
    false
  end
end
