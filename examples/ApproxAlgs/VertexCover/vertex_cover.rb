require 'graphsrb'
include Graphsrb

# 2-approximation for vertex-cover problem
module ApproxAlgs
  module VertexCover
    def self.run(graph)
      vertex_cover = []
      edges = graph.edges

      while edges.size > 0
        edge = edges.first
        v = edge.initial_vertex
        u = edge.terminal_vertex
        vertex_cover.concat([v,u])
        edges = remove_incident_edges(edges, u, v)
      end
      vertex_cover
    end

    def self.remove_incident_edges(edges, v, u)
      remaining_edges = []
      edges.each do |e|
        next if e.initial_vertex == v || e.terminal_vertex == v
        next if e.initial_vertex == u || e.terminal_vertex == u
        remaining_edges << e
      end
      remaining_edges
    end
  end
end
