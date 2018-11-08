
class Graphsrb::Edge
  attr_reader :vertex1, :vertex2, :weight
  def initialize(id1, id2, args={})
    @vertex1 = Vertex.new(id1)
    @vertex2 = Vertex.new(id2)
    @weight = args[:weight] || 1
  end

  def ==(edge)
    (vertex1.id == edge.vertex1.id) && (vertex2.id == edge.vertex2.id) ||
    (vertex1.id == edge.vertex2.id) && (vertex2.id == edge.vertex1.id)
  end
end
