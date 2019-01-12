require 'graphsrb'
require_relative '../MaxFlow/edmonds_karp'
include Graphsrb

# The edge-connectivity λ(G) of a connected graph G is the smallest number of edges
# whose removal disconnects G.
module EdgeConnectivity
  MAX_INT = (2**(0.size * 8 -2) -1)

  def self.run(graph)
    init(graph)
    min_maxflow = MAX_INT
    u = graph.vertices.first

    graph.vertices.each do |v|
      next if u == v
      maxflow = EdmondsKarp.run(@graph, u, v)
      min_maxflow = maxflow if min_maxflow > maxflow
    end

    min_maxflow
  end

  def self.init(graph)
    @graph = Digraph.new
    graph.edges.each do |e|
      @graph.add_edge(e.initial_vertex.id, e.terminal_vertex.id, weight:1)
      @graph.add_edge(e.terminal_vertex.id, e.initial_vertex.id, weight:1)
    end
  end
end
