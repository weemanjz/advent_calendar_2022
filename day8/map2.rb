class Map2
  def initialize
    @map = []
    @top_scenic = 0
  end

  def add_row(row)
    @map << row
  end

  def top_scenic_score
    1.upto(x - 2) do |i|
      1.upto(y - 2) do |j|
        score = scenic_score(i, j, @map[i][j])
        @top_scenic = score if score > @top_scenic
      end
    end
    @top_scenic
  end

  private

  def scenic_score(i, j, h)
    score = 1
    dir = 0
    (i - 1).downto(0) do |a|
      dir += 1
      break if @map[a][j] >= h
    end
    score *= dir

    dir = 0
    (j - 1).downto(0) do |a|
      dir += 1
      break if @map[i][a] >= h
    end
    score *= dir

    dir = 0
    (i + 1).upto(x - 1) do |a|
      dir += 1
      break if @map[a][j] >= h
    end
    score *= dir

    dir = 0
    (j + 1).upto(y - 1) do |a|
      dir += 1
      break if @map[i][a] >= h
    end

    score * dir
  end

  def x
    @map[0].size
  end

  def y
    @map.size
  end
end
