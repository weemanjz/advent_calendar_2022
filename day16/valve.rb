class Valve
  attr_reader :name, :pressure, :connections

  def initialize(name, pressure, connections)
    @name = name
    @pressure = pressure
    @connections = connections.to_h { |c| [c, 1] }
  end

  def add_connection(to, min)
    @connections[to] = min if @connections[to].nil? || @connections[to] > min
  end

  def remove_connection(to)
    @connections.delete(to)
  end
end
