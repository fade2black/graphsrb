require "graphsrb/digraph"
require "graphsrb/edge"

RSpec.describe Graphsrb::Digraph do
  it "creates an empty digraph" do
    graph = described_class.new
    expect(graph.vertex_count).to be 0
    expect(graph.edge_count).to be 0
  end

  it "has edges with initial and terminal vertices" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.edge(1,2).initial_vertex.id).to eq(1)
    expect(graph.edge(1,2).terminal_vertex.id).to eq(2)
    expect(graph.edge(2,1).initial_vertex.id).to eq(2)
    expect(graph.edge(2,1).terminal_vertex.id).to eq(1)
    expect(graph.edge(3,2)).to be nil
    expect(graph.edge(2,3).initial_vertex.id).to eq(2)
    expect(graph.edge(2,3).terminal_vertex.id).to eq(3)
  end

  it "creates a digraph" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.vertex_count).to be 3
    expect(graph.has_vertex?(1)).to be true
    expect(graph.has_vertex?(2)).to be true
    expect(graph.has_vertex?(3)).to be true
    expect(graph.has_vertex?(4)).to be false
    expect(graph.has_vertex?(-4)).to be false
    expect(graph.has_vertex?('4')).to be false

    expect(graph.has_edge?(1,2)).to be true
    expect(graph.has_edge?(2,1)).to be true

    expect(graph.has_edge?(3,2)).to be false
    expect(graph.has_edge?(2,3)).to be true
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(3,3)).to be false
    expect(graph.edge_count).to be 3
  end

  it "adds a new edge" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])
    expect(graph.vertex_count).to be 3
    expect(graph.edge_count).to be 3
    expect(graph.has_vertex?(4)).to be false
    expect(graph.has_vertex?(5)).to be false
    expect(graph.has_edge?(4,5)).to be false
    expect(graph.has_edge?(5,4)).to be false

    graph.add_edge(4,5)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 4
    expect(graph.has_vertex?(4)).to be true
    expect(graph.has_vertex?(5)).to be true
    expect(graph.has_edge?(4,5)).to be true
    expect(graph.has_edge?(5,4)).to be false

    graph.add_edge(4,6)
    expect(graph.vertex_count).to be 6
    expect(graph.edge_count).to be 5
    expect(graph.has_edge?(4,6)).to be true
    expect(graph.has_edge?(6,4)).to be false
  end

  it "removes an edge" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,1,1], [2,3,1], [2,5,1]])
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 4
    expect(graph.has_edge?(1,2)).to be true
    expect(graph.has_edge?(2,1)).to be true
    expect(graph.has_edge?(2,5)).to be true
    expect(graph.has_edge?(5,2)).to be false

    graph.remove_edge(1,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(1,2)).to be false

    graph.remove_edge(5,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(5,2)).to be false
    expect(graph.has_edge?(2,5)).to be true

    graph.remove_edge(2,5)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2

    graph.remove_edge(3,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(3,2)).to be false
    expect(graph.has_edge?(2,3)).to be true

    graph.remove_edge(2,3)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 1
    expect(graph.has_edge?(2,3)).to be false

    expect(graph.has_edge?(2,1)).to be true
  end

  it "creates a vertex even if it is not included in the vertices list" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [1,3,1], [3,5,1]])
    expect(graph.has_edge?(3,5)).to be true
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 4
  end

  it "removes a vertex" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,5,1], [6,1,1], [2,6]])
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 5

    graph.remove_vertex(1)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(6,1)).to be false
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(1,11)).to be false

    graph.add_vertex(1)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 3
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(6,1)).to be false
    expect(graph.has_edge?(1,3)).to be false

    graph.remove_vertex(1)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 3

    graph.add_vertex(1)
    graph.add_edge(1,6)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 4
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be true
    expect(graph.has_edge?(6,1)).to be false
    expect(graph.has_edge?(1,3)).to be false

    graph.add_edge(6,1)
    expect(graph.vertex_count).to be 5
    expect(graph.edge_count).to be 5
    expect(graph.has_edge?(1,6)).to be true
    expect(graph.has_edge?(6,1)).to be true

    graph.remove_vertex(1)
    graph.remove_vertex(6)
    expect(graph.vertex_count).to be 3
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(6,2)).to be false
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(2,5)).to be true
    expect(graph.has_edge?(2,3)).to be true

    graph.remove_vertex(2)
    expect(graph.vertex_count).to be 2
    expect(graph.edge_count).to be 0

    graph.add_edge(5,3)
    expect(graph.vertex_count).to be 2
    expect(graph.edge_count).to be 1
    graph.add_edge(3,5)
    expect(graph.vertex_count).to be 2
    expect(graph.edge_count).to be 2
    expect(graph.has_edge?(1,2)).to be false
    expect(graph.has_edge?(1,6)).to be false
    expect(graph.has_edge?(1,3)).to be false

    graph.add_edge(1,2)
    expect(graph.vertex_count).to be 4
    expect(graph.edge_count).to be 3

    expect(graph.has_edge?(1,2)).to be true
    expect(graph.has_edge?(5,3)).to be true
    expect(graph.has_edge?(3,5)).to be true
    expect(graph.has_edge?(1,3)).to be false
    expect(graph.has_edge?(5,2)).to be false
  end

  it "retrieves outgoing edges of a vertex" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [1,3,1], [3,5,1], [1,6,4]])
    edges = graph.outgoing_edges(1)
    expect(edges.size).to eq(3)
    [Graphsrb::Edge.new(1,2), Graphsrb::Edge.new(1,3),
      Graphsrb::Edge.new(1,6)].each do |edge|
        expect(edges.include?(edge)).to be true
      end

    edges = graph.outgoing_edges(2)
    expect(edges.size).to be 1
    expect(edges.include?(Graphsrb::Edge.new(2,3))).to be true
    expect(edges.include?(Graphsrb::Edge.new(3,1))).to be false

    edges = graph.outgoing_edges(6)
    expect(edges.size).to be 0

    edges = graph.outgoing_edges(11)
    expect(edges.size).to be 0
  end

  it "retrieves incoming edges of a vertex" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [1,3,1], [3,5,1], [1,6,4]])
    edges = graph.incoming_edges(3)
    expect(edges.size).to eq(2)
    [Graphsrb::Edge.new(2,3), Graphsrb::Edge.new(1,3)].each do |edge|
      expect(edges.include?(edge)).to be true
    end

    edges = graph.incoming_edges(6)
    expect(edges.size).to eq(1)
    expect(edges.include?(Graphsrb::Edge.new(1,6))).to be true

    edges = graph.incoming_edges(1)
    expect(edges.size).to eq(0)

    edges = graph.incoming_edges(11)
    expect(edges.size).to eq(0)
  end

  it "retrieves edge information" do
    graph = described_class.new(vertices: [1,2,3], edges:[[1,2,-1], [2,3,1], [2,5,1], [6,1,0.4]])
    edge = graph.edge(1,2)
    expect(edge.vertex1.id).to be 1
    expect(edge.vertex2.id).to be 2
    expect(edge.weight).to be -1

    edge = graph.edge(2,1)
    expect(edge).to be nil
    edge = graph.edge(1,5)
    expect(edge).to be nil

    edge = graph.edge(1,6)
    expect(edge).to be nil
    edge = graph.edge(6,1)
    expect(edge.vertex1.id).to be 6
    expect(edge.vertex2.id).to be 1
    expect(edge.weight).to be 0.4
  end

  it "returns out-degree" do
    graph = described_class.new(vertices: [1,2,3,5], edges:[[1,2,1], [2,3,1], [2,1,1], [1,4]])
    expect(graph.indegree(1)).to eq(1)
    expect(graph.outdegree(1)).to eq(2)

    expect(graph.indegree(2)).to eq(1)
    expect(graph.outdegree(2)).to eq(2)

    expect(graph.outdegree(4)).to eq(0)
    expect(graph.indegree(4)).to eq(1)

    expect(graph.indegree(3)).to eq(1)
    expect(graph.outdegree(3)).to eq(0)

    expect(graph.outdegree(5)).to eq(0)
    expect(graph.indegree(5)).to eq(0)

    expect(graph.outdegree(9)).to eq(0)
    expect(graph.indegree(9)).to eq(0)
  end
end
