class Map
  def initialize
    @map = []
    @top_max = []
    @bottom_max = []
    @left_max = []
    @right_max = []
  end

  def add_row(row)
    @map << row
    @top_max << row.dup
    @bottom_max << row.dup
    @left_max << row.dup
    @right_max << row.dup
  end

  def visible_trees_count
    count = 0
    x.times do |i|
      y.times do |j|
        count += 1 if visible?(i, j)
      end
    end
    count
  end

  def calculate_max_heights
    y.times do |j|
      (1...x).each do |i|
        @top_max[i][j] = @top_max[i - 1][j] if @top_max[i - 1][j] > @top_max[i][j]
      end
      (0..(x - 2)).to_a.reverse.each do |i|
        @bottom_max[i][j] = @bottom_max[i + 1][j] if @bottom_max[i + 1][j] > @bottom_max[i][j]
      end
    end
    x.times do |i|
      (1...y).each do |j|
        @left_max[i][j] = @left_max[i][j - 1] if @left_max[i][j - 1] > @left_max[i][j]
      end
      (0..(y - 2)).to_a.reverse.each do |j|
        @right_max[i][j] = @right_max[i][j + 1] if @right_max[i][j + 1] > @right_max[i][j]
      end
    end
  end

  private

  def visible?(i, j)
    return true if i == 0 || j == 0 || i == x - 1 || j == y - 1
    return true if @map[i][j] > @top_max[i - 1][j]
    return true if @map[i][j] > @bottom_max[i + 1][j]
    return true if @map[i][j] > @left_max[i][j - 1]
    return true if @map[i][j] > @right_max[i][j + 1]
    false
  end

  def x
    @map[0].size
  end

  def y
    @map.size
  end
end
