require "graphsrb/graph"
require "graphsrb/edge"
require "graphsrb/vertex"

RSpec.describe Graphsrb::Graph do
  it "creates en empty graph" do
    graph = described_class.new
    expect(graph.vertex_count).to be 0
    expect(graph.edge_count).to be 0
  end

  it "checks if edge vertices are different (disallows loops)" do
    expect{described_class.new(edges:[[1,2,1], [2,2,1]])}.to raise_error(Graphsrb::EdgeInitializationError)
  end

  it "creates a graph" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.vertex_count).to be 3
    expect(graph.has_vertex?(1)).to be true
    expect(graph.has_vertex?(2)).to be true
    expect(graph.has_vertex?(3)).to be true
    expect(graph.has_vertex?(4)).to be false
    expect(graph.has_vertex?(-4)).to be false
    expect(graph.has_vertex?('4')).to be false
    expect(graph.has_edge?(2,1)).to be true
    expect(graph.has_edge?(3,2)).to be true
    expect(graph.has_edge?(2,3)).to be true
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(3,3)).to be false
    expect(graph.edge_count).to be 2
  end


  it "creates alias for 'vertex?' " do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.vertex?(1)).to be true
    expect(graph.vertex?(4)).to be false
  end

  it "creates alias for 'edge?' " do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.edge?(1,2)).to be true
    expect(graph.edge?(1,4)).to be false
  end

  it "returns degree of a vertex" do
    graph = described_class.new(vertices: [9], edges:[[2,1], [2,3], [2,5], [5,3]])
    expect(graph.degree(Graphsrb::Vertex.new(3))).to eq(2)
    expect(graph.degree(Graphsrb::Vertex.new(1))).to eq(1)
    expect(graph.degree(Graphsrb::Vertex.new(2))).to eq(3)
    expect(graph.degree(Graphsrb::Vertex.new(5))).to eq(2)
    expect(graph.degree(Graphsrb::Vertex.new(9))).to eq(0)
    expect(graph.degree(Graphsrb::Vertex.new(6))).to eq(0)
  end

  it "returns vertices" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,5,1], [6,1,1]])
    vertices = graph.vertices
    expect(vertices.size).to be 5
    [1,2,3,5,6].each { |id| expect(vertices.include?(Graphsrb::Vertex.new(id))).to be true }
  end

  it "returns edges" do
    edges_array = [[1,2,1], [2,3,1], [2,5,1], [6,1,1]]
    graph = described_class.new(vertices: [1,2,3], edges:edges_array)
    edges = graph.edges
    expect(edges.count).to be 4
    edges_array.each do |e|
      expect(edges.include?(Graphsrb::Edge.new(e[0],e[1]))).to be true
    end

    graph.clear
    edges = graph.edges
    expect(graph.edges.count).to be 0
    edges_array.each do |e|
      expect(edges.include?(Graphsrb::Edge.new(e[0],e[1]))).to be false
    end
  end

  it "adds a new vertex" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.has_vertex?(4)).to be false
    graph.add_vertex(4)
    expect(graph.has_vertex?(4)).to be true
  end

  it "adds a new edge" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.vertex_count).to be 3
    expect(graph.edge_count).to be 2
    expect(graph.has_vertex?(4)).to be false
    expect(graph.has_vertex?(5)).to be false
    expect(graph.has_edge?(4,5)).to be false
    expect(graph.has_edge?(5,4)).to be false

    graph.add_edge(4,5)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 3
    expect(graph.has_vertex?(4)).to be true
    expect(graph.has_vertex?(5)).to be true
    expect(graph.has_edge?(4,5)).to be true
    expect(graph.has_edge?(5,4)).to be true

    graph.add_edge(4,6)
    expect(graph.vertex_count).to be 6
    expect(graph.edge_count).to be 4
    expect(graph.has_edge?(4,6)).to be true
    expect(graph.has_edge?(6,4)).to be true

    expect{graph.add_edge(7,7)}.to raise_error(Graphsrb::EdgeInitializationError)
  end

  it "does not add a new edge if it already exists" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [1,3,1]])
    graph.add_edge(3,1)
    expect(graph.vertex_count).to be 3
    expect(graph.edge_count).to be 3
  end

  it "creates a vertex even if it is not included in the vertices list" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [1,3,1], [3,5,1]])
    expect(graph.has_edge?(5,3)).to be true
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 4
  end

  it "removes an edge" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,5,1]])
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(1,2)).to be true
    expect(graph.has_edge?(5,2)).to be true

    graph.remove_edge(Graphsrb::Vertex.new(1), Graphsrb::Vertex.new(2))
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false

    graph.remove_edge(Graphsrb::Vertex.new(5), Graphsrb::Vertex.new(2))
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 1
    expect(graph.has_edge?(5,2)).to be false

    graph.remove_edge(Graphsrb::Vertex.new(2), Graphsrb::Vertex.new(5))
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 1

    graph.remove_edge(Graphsrb::Vertex.new(3), Graphsrb::Vertex.new(2))
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 0
    expect(graph.has_edge?(3,2)).to be false
  end

  it "removes a vertex" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,5,1], [6,1,1]])
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 4

    graph.remove_vertex(Graphsrb::Vertex.new(1))
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(1,11)).to be false

    graph.add_vertex(1)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(1,3)).to be false

    graph.remove_vertex(Graphsrb::Vertex.new(1))
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2

    graph.add_vertex(1)
    graph.add_edge(1,6)
    expect(graph.vertex_count).to eq(5)
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be true
    expect(graph.has_edge?(1,3)).to be false

    graph.add_edge(6,1)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 3

    graph.remove_vertex(Graphsrb::Vertex.new(1))
    graph.remove_vertex(Graphsrb::Vertex.new(6))
    expect(graph.vertex_count).to be 3
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(1,3)).to be false

    graph.remove_vertex(Graphsrb::Vertex.new(2))
    expect(graph.vertex_count).to be 2
    expect(graph.edge_count).to be 0

    graph.add_edge(5,3)
    expect(graph.vertex_count).to be 2
    expect(graph.edge_count).to be 1
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(5,3)).to be true

    graph.add_edge(1,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2

    expect(graph.has_edge?(1,2)).to be true
    expect(graph.has_edge?(5,3)).to be true
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(5,2)).to be false
  end

  it "retrieves edge information" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,-1], [2,3,1], [2,5,1], [6,1,0.4]])
    edge = graph.edge(Graphsrb::Vertex.new(1),Graphsrb::Vertex.new(2))
    expect(edge.vertex1.id).to be 1
    expect(edge.vertex2.id).to be 2
    expect(edge.weight).to be -1

    edge = graph.edge(Graphsrb::Vertex.new(1),Graphsrb::Vertex.new(5))
    expect(edge).to be nil

    edge = graph.edge(Graphsrb::Vertex.new(1),Graphsrb::Vertex.new(6))
    expect(edge.vertex1.id).to be 1
    expect(edge.vertex2.id).to be 6
    expect(edge.weight).to be 0.4
  end

  it "retrieves incident edges" do
    graph = described_class.new(vertices: [1,2,3,4], edges:[[1,2,-1], [2,3,1], [2,5,1], [6,1,0.4]])
    edges = graph.incident_edges(Graphsrb::Vertex.new(1))
    expect(edges.size).to be 2

    expect(edges.include?(Graphsrb::Edge.new(1,2, weight:-1))).to be true
    expect(edges.include?(Graphsrb::Edge.new(1,6, weight:0.4))).to be true

    graph.add_edge(1,3, weight:22)
    edges = graph.incident_edges(Graphsrb::Vertex.new(1))
    expect(edges.size).to be 3
    expect(edges.include?(Graphsrb::Edge.new(1,3))).to be true
  end

  it "retrieves adjacent vertices" do
    graph = described_class.new(vertices: [1,2,3,4,8], edges:[[1,2,-1], [2,3,1], [2,5,1], [6,1,0.4]])

    vertices = graph.neighborhood(Graphsrb::Vertex.new(1))
    expect(vertices.size).to be 2
    expect(vertices.include? Graphsrb::Vertex.new(1)).to be false
    expect(vertices.include? Graphsrb::Vertex.new(2)).to be true
    expect(vertices.include? Graphsrb::Vertex.new(6)).to be true

    graph.remove_edge(Graphsrb::Vertex.new(1),Graphsrb::Vertex.new(6))
    vertices = graph.neighborhood(Graphsrb::Vertex.new(1))
    expect(vertices.size).to be 1
    expect(vertices.include? Graphsrb::Vertex.new(2)).to be true
    expect(vertices.include? Graphsrb::Vertex.new(6)).to be false

    vertices = graph.neighborhood(Graphsrb::Vertex.new(8))
    expect(vertices.size).to be 0

    expect(graph.adjacent_vertices(Graphsrb::Vertex.new(9)).size).to be 0

    graph.add_edge(3,2)
    graph.add_edge(2,6)
    graph.add_edge(2,11)
    vertices = graph.adjacent_vertices(Graphsrb::Vertex.new(2))
    expect(vertices.size).to be 5

    graph.clear
    vertices = graph.neighborhood(Graphsrb::Vertex.new(1))
    expect(vertices.size).to be 0
  end

  it "retrieves empty set (of edges)" do
    graph = described_class.new(vertices: [1,2,3,4], edges:[[1,2,-1],[2,5,1], [6,1,0.4]])
    edges = graph.incident_edges(Graphsrb::Vertex.new(4))
    expect(edges.size).to be 0

    edges = graph.incident_edges(Graphsrb::Vertex.new(9))
    expect(edges.size).to be 0

    graph.remove_edge(Graphsrb::Vertex.new(5),Graphsrb::Vertex.new(2))
    edges = graph.incident_edges(Graphsrb::Vertex.new(5))
    expect(edges.size).to be 0
  end

  it "updates weights" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,[0,1]], [2,3,[0,2]], [1,3,[0,8]]])
    v = graph.vertices[0]
    u = graph.vertices[1]
    expect(graph.edge(u,v).weight).to eq([0,1])
    graph.update_weight(u,v,[1,2])
    expect(graph.edge(u,v).weight).to eq([1,2])
    expect(graph.edge(v,u).weight).to eq([1,2])
  end

  it "increases weights by some value" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,-2], [2,3,2], [1,3,8]])
    v = Graphsrb::Vertex.new(1)
    u = Graphsrb::Vertex.new(2)
    t = Graphsrb::Vertex.new(3)

    expect(graph.edge(u,v).weight).to eq(-2)
    graph.increase_weight(u,v,2)
    expect(graph.edge(u,v).weight).to eq(0)
    expect(graph.edge(v,u).weight).to eq(0)

    expect(graph.edge(v,t).weight).to eq(8)
    graph.increase_weight(t,v,-2)
    expect(graph.edge(v,t).weight).to eq(6)
    expect(graph.edge(t,v).weight).to eq(6)
  end
end
