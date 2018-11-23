
class Graphsrb::DiEdge < Graphsrb::Edge
  def ==(edge)
    (vertex1.id == edge.vertex1.id) && (vertex2.id == edge.vertex2.id)
  end
end
