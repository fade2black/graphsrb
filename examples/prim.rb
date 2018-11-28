require 'graphsrb'
include Graphsrb

#Assumption: graph is nonempty connected undirected
module PrimMST
  FIXNUM_MAX = (2**(0.size * 8 -2) -1)

  def self.run(graph)
    init(graph)
    vertices = graph.vertices

    start = vertices.first
    @parent[start.id] = nil
    include_vertex(start)

    edges = graph.incident_edges(start)
    edges.each{|edge| @dist[v.id] = edge.weight }

    while not all_vertices_included?

    end


  end


  def self.init(g)
    @graph = g
    @vertex_count = g.vertex_count
    @included_vertex_count = 0
    @included = []
    @dist = []
    @tree = []
    @parent = []
    @graph.vertices.each do |v|
      @included[v.id] = false
      @dist[v.id] = FIXNUM_MAX
    end
  end

  def self.included?(v)
    @included[v.id]
  end

  def self.include_vertex(v)
    @included[v.id] = true
    @included_vertex_count += 1
    #Update distances
    min =
    @graph.vertices.each do |u|
      if not included?(u) &&
      end
    end
  end

  def self.all_vertices_included?
    @included_vertex_count == @vertex_count
  end

  def self.min_dist_vertex

  end
end
