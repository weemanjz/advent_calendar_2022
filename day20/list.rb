class Item
  attr_reader :val
  attr_accessor :left, :right

  def initialize(val, left, right)
    @val = val
    @left = left
    @right = right
    left&.right = self
    right&.left = self
  end

  def find(steps)
    pos = self
    steps.times { pos = pos.right }
    pos.val
  end

  def move(count)
    return if (val % (count - 1)) == 0

    left.right = right
    right.left = left
    pos = self
    if val > 0
      (val % (count - 1)).times { pos = pos.right }
      self.left = pos
      self.right = pos.right
      left.right = self
      right.left = self
    else
      (val.abs % (count - 1)).times { pos = pos.left }
      self.right = pos
      self.left = pos.left
      right.left = self
      left.right = self
    end
  end
end

class List
  def initialize
    @head = nil
    @count = 0
  end

  def append(val)
    @count += 1
    item = Item.new(val, @head&.left, @head)
    if @head.nil?
      item.left = item
      item.right = item
      @head = item
    end
    item
  end

  def move(elem)
    @head = elem.right if elem == @head
    elem.move(@count)
  end

  def to_a
    return [] if @head.nil?

    ret = []
    pos = @head
    @count.times do
      ret << pos.val
      pos = pos.right
    end
    ret
  end
end
