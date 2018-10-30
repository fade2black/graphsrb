module Graphsrb
  ##
  #This class represents a vertex in a graph. Each vertex is identified by an +id+, a unique nonnegative integer over a whole graph.

  class Vertex
    attr_reader :neighbours, :display_name, :id
    ##
    #Creates a new vertex given a +display name+ and +id+
    def initialize(args = {})
      @neighbours = []
      @display_name = args.fetch(:display_name, 'Untitled')
      if args.key?(:id)
        @id = args[:id]
      else
        raise Graphsrb::VertexInitializationError, 'Missing vertex id'
      end
    end

    ##
    #Compares two vertices. Two vertices are equal if their +id+s are equal
    def ==(nghb)
      @id == nghb.id
    end

    ##
    #Returns the degree of the vertex
    def degree
      @neighbours.size
    end

    ##
    #Adds a new adjacent vertex to the adjaceny list
    def add_neighbour(nghb)
      @neighbours << nghb.clone
    end

    ##
    #Given vertex +id+ removes the vertex from the adjaceny list with this +id+
    def remove_neighbour(id)
      @neighbours.delete(Vertex.new(id:id))
    end

    ##
    #Checks if a vertex is isolated. A vertex is isolated if it has no adjacent vertex
    def isolated?
      degree == 0
    end



  end
end
