require 'graphsrb'
include Graphsrb

# Exponential algorithm for computing the size of a maximum
# independednt set in a graph.
#
# Recursively computes a maximum independent set in a graph G.
# If G has only one vertex then MIS(G) = 1.
# Otherwise recursively compute
#          MIS(G-x) and 1 + MIS(G-{x}-Nghb(x))
# Return the maximum of these two vlaues.

module MIS
  def self.run(graph)
    mis(graph)
  end

  def self.mis(g)
    cnt = g.vertex_count
    return 0 if  cnt == 0
    return 1 if cnt == 1

    v = g.vertices.first

    g1,g2 = copy(g),copy(g)
    g1.remove_vertex(v)
    mis1 = mis(g1)

    adj_vertices = g2.adjacent_vertices(v)
    g2.remove_vertex(v)
    adj_vertices.each{|v| g2.remove_vertex(v)}
    mis2 = 1+mis(g2)

    [mis1,mis2].max
  end

  def self.copy(graph)
    g = Graph.new
    graph.vertices.each{|v| g.add_vertex(v.id)}
    graph.edges.each do |edge|
      g.add_edge(edge.initial_vertex.id, edge.terminal_vertex.id)
    end
    g
  end
end
