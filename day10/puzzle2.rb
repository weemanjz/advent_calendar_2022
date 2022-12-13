require_relative "crt"

cpu = Crt.new

while (l = gets)
  cpu.exe(l.strip)
end

cpu.draw
