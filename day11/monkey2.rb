class Monkey
  attr_reader :items, :total

  def initialize(items, operation, test, on_true, on_false)
    @items = items
    @operation = operation.split(" ")
    @test = test.to_i
    @on_true = on_true
    @on_false = on_false
    @total = 0
  end

  def turn
    @total += @items.size
    throws = []
    while (elem = @items.shift)
      new_value = inspect_item(elem)
      test_res = test_item(new_value)
      throw_to = test_res ? @on_true : @on_false
      throws << {item: new_value, to: throw_to}
    end
    throws
  end

  def inspect
    puts @total
  end

  private

  def inspect_item(item)
    a = (@operation[0] == "old") ? item : @operation[0].to_i
    b = (@operation[2] == "old") ? item : @operation[2].to_i
    (@operation[1] == "*") ? a * b : a + b
  end

  def test_item(item)
    item % @test == 0
  end
end
