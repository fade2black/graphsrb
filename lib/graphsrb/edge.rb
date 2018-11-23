
class Graphsrb::Edge
  attr_reader :vertex1, :vertex2, :weight
  def initialize(id1, id2, args={})
    if id1 == id2
      raise Graphsrb::EdgeInitializationError, "Vertex id's must be different from each other"
    end

    @vertex1 = Graphsrb::Vertex.new(id1)
    @vertex2 = Graphsrb::Vertex.new(id2)
    @weight = args.fetch(:weight, 1)
  end

  alias initial_vertex vertex1
  alias terminal_vertex vertex2

  def ==(other)
    (vertex1.id == other.vertex1.id) && (vertex2.id == other.vertex2.id) ||
    (vertex1.id == other.vertex2.id) && (vertex2.id == other.vertex1.id)
  end

  def eql?(other)
    self == other
  end

  def to_s
    "(#{vertex1.id}, #{vertex2.id}, weight:#{weight})"
  end

  def to_json
    {vertex1: vertex1.id, vertex2: vertex2.id, weight: weight}.to_json
  end

end
