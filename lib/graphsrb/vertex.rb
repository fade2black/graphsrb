
#This class represents a graph vertex.
class Graphsrb::Vertex
  attr_reader :id

  #Creates a vertex given its +id+, a nonnegative integer.
  def initialize(id)
    raise Graphsrb::VertexInitializationError, 'Vertex id may not be nil' if id.nil?
    @id = id
  end

  #Compares two vertices. Two vertices are equal if their +id+s are equal.
  def ==(vertex)
    id == vertex.id
  end

  def eql?(other)
    self == other
  end

  def to_s
    self.id.to_s
  end

  def hash
    self.id
  end
end
