module Graphsrb
  ##
  #This class represents a single entry in a adjacency list.
  class Node
    attr_reader :vertex, :weight

    #Creates a new node
    def initialize(vertex, args={})
      @vertex = vertex.clone
      @weight = args.fetch(:weight, 1)
    end

    #Compares two nodes. Two nodes are equal if their +vertices+ are equal.
    def ==(node)
      vertex == node.vertex
    end
  end
end
