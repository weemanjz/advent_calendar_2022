class Directory
  attr_reader :directories, :size, :parent

  def initialize(parent)
    @parent = parent
    @size = 0
    @directories = {}
  end

  def cd(dir)
    @directories[dir] ||= Directory.new(self)
  end

  def reset_size
    @size = 0
  end

  def inc_size(size)
    @size += size
  end
end

root = Directory.new(nil)
current = nil

def handle_cd(dir, root, current)
  case dir
  when "/"
    root
  when ".."
    current.parent
  else
    current.cd(dir)
  end
end

while (l = gets)
  l.strip!
  cd = l.match(/\A\$ cd (.+)/)
  if cd
    current = handle_cd(cd[1], root, current)
    next
  end
  next if l.start_with?("dir ")
  if l == "$ ls"
    current.reset_size
    next
  end
  size, _ = l.split(" ")
  current.inc_size(size.to_i)
end

class CalculateSizes
  MAX_SIZE = 100_000

  attr_reader :sum

  def initialize(root)
    @root = root
    @sum = 0
  end

  def call
    sub_size(@root)
  end

  private

  def sub_size(dir)
    size = dir.directories.reduce(0) { |sum, (_, subdir)| sum + sub_size(subdir) }
    total_size = size + dir.size
    @sum += total_size if total_size <= MAX_SIZE
    total_size
  end
end

calc = CalculateSizes.new(root)
calc.call

puts calc.sum
