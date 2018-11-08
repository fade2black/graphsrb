
#This class represents a single entry in a adjacency list.
class Graphsrb::Node
  attr_reader :vertex, :weight

  #Creates a new node
  def initialize(vertex_id, args={})
    @vertex = Graphsrb::Vertex.new(vertex_id)
    @weight = args[:weight]
  end

  #Compares two nodes. Two nodes are equal if their +vertices+ are equal.
  def ==(node)
    vertex == node.vertex
  end
end
