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

class System
  SPACE = 70000000
  SPACE_FOR_UPDATE = 30000000

  def initialize(root)
    @root = root
    @dir_spaces = []
  end

  def space_left
    SPACE - sub_size(@root)
  end

  def prepare_for_update
    needed_space = SPACE_FOR_UPDATE - space_left
    to_remove = SPACE
    @dir_spaces.each { |sp| to_remove = sp if sp > needed_space && sp < to_remove }
    to_remove
  end

  private

  def sub_size(dir)
    size = dir.directories.reduce(0) { |sum, (_, subdir)| sum + sub_size(subdir) }
    total = size + dir.size
    @dir_spaces << total
    total
  end
end

calc = System.new(root)

puts calc.prepare_for_update
