require "graphsrb/graph"
require "graphsrb/edge"

RSpec.describe Graphsrb::Graph do
  it "raises exception" do
    expect{described_class.new}.to raise_error Graphsrb::VertexInitializationError
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

  it "returns vertices" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,5,1], [6,1,1]])
    vertices = graph.vertices

    expect(vertices.size).to be 5
    expect(([1,2,3,5,6] - vertices).empty?).to be true
    expect((vertices - [1,2,3,5,6]).empty?).to be true
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

    graph.remove_edge(1,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false

    graph.remove_edge(5,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 1
    expect(graph.has_edge?(5,2)).to be false

    graph.remove_edge(2,5)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 1

    graph.remove_edge(3,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 0
    expect(graph.has_edge?(3,2)).to be false
  end

  it "removes a vertex" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,5,1], [6,1,1]])
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 4

    graph.remove_vertex(1)
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

    graph.remove_vertex(1)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2

    graph.add_vertex(1)
    graph.add_edge(1,6)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be true
    expect(graph.has_edge?(1,3)).to be false

    graph.add_edge(6,1)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 3

    graph.remove_vertex(1)
    graph.remove_vertex(6)
    expect(graph.vertex_count).to be 3
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(1,3)).to be false

    graph.remove_vertex(2)
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
    edge = graph.edge(1,2)
    expect(edge.vertex1.id).to be 1
    expect(edge.vertex2.id).to be 2
    expect(edge.weight).to be -1

    edge = graph.edge(1,5)
    expect(edge).to be nil

    edge = graph.edge(1,6)
    expect(edge.vertex1.id).to be 1
    expect(edge.vertex2.id).to be 6
    expect(edge.weight).to be 0.4
  end

  it "retrieves incident edges" do
    graph = described_class.new(vertices: [1,2,3,4], edges:[[1,2,-1], [2,3,1], [2,5,1], [6,1,0.4]])
    edges = graph.incident_edges(1)
    expect(edges.size).to be 2

    expect(edges.include?(Graphsrb::Edge.new(1,2, weight:-1))).to be true
    expect(edges.include?(Graphsrb::Edge.new(1,6, weight:0.4))).to be true

    graph.add_edge(1,3, weight:22)
    edges = graph.incident_edges(1)
    expect(edges.size).to be 3
    expect(edges.include?(Graphsrb::Edge.new(1,3))).to be true
  end

  it "retrieves empty set (of edges)" do
    graph = described_class.new(vertices: [1,2,3,4], edges:[[1,2,-1],[2,5,1], [6,1,0.4]])
    edges = graph.incident_edges(4)
    expect(edges.size).to be 0

    edges = graph.incident_edges(9)
    expect(edges.size).to be 0

    graph.remove_edge(5,2)
    edges = graph.incident_edges(5)
    expect(edges.size).to be 0
  end
end
