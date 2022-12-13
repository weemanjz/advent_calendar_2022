require_relative "cpu"

cpu = Cpu.new

while (l = gets)
  cpu.exe(l.strip)
  break if cpu.cycle > 220
end

puts cpu.sum
