module Graphsrb
  ##
  #This class represents a graph vertex.
  class Vertex
    attr_reader :id

    #Creates a vertex given its +id+, a nonnegative integer.
    def initialize(id)
      raise VertexInitializationError, 'Vertex id may not be nil' if id.nil?
      @id = id
    end

    #Compares two vertices. Two vertices are equal if their +id+s are equal.
    def ==(vertex)
      id == vertex.id
    end
  end
end
