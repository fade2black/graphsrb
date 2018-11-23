
class Graphsrb::DiEdge < Graphsrb::Edge
  def ==(other)
    (vertex1.id == other.vertex1.id) && (vertex2.id == other.vertex2.id)
  end
end
