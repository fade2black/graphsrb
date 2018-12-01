require 'graphsrb'
include Graphsrb

#Assumption: graph is nonempty connected undirected
module PrimMST
  INF = (2**(0.size * 8 -2) -1)

  def self.run(graph)
    init(graph)

    start = graph.vertices.first
    include_vertex(start)

    adj_vertices = graph.adjacent_vertices(start)
    adj_vertices.each do |v|
      @dist[v.id] = graph.edge(start, v).weight
      @parent[v.id] = start
    end

    while not all_vertices_included?
      v = min_dist_vertex
      include_vertex(v)
      update_distances(v)
    end

    edges = []
    (0...@parent.size).each do |i|
      edges << graph.edge(@parent[i], Vertex.new(i)) if @parent[i]
    end
    edges
  end


  def self.init(g)
    @graph = g
    @vertex_count = g.vertex_count
    @included_vertex_count = 0
    @included = []
    @dist = []
    @parent = []
    @graph.vertices.each do |v|
      @included[v.id] = false
      @dist[v.id] = INF
    end
  end

  def self.included?(v)
    @included[v.id]
  end

  def self.include_vertex(v)
    @included[v.id] = true
    @included_vertex_count += 1
  end

  def self.update_distances(v)
    vertices = @graph.adjacent_vertices(v)
    vertices.each do |u|
      edge = @graph.edge(v,u)
      if !included?(u) && (@dist[u.id] > edge.weight)
        @dist[u.id] = edge.weight
        @parent[u.id] = v
      end
    end
  end

  def self.all_vertices_included?
    @included_vertex_count == @vertex_count
  end

  def self.min_dist_vertex
    min = INF
    vertex = nil
    @graph.vertices.each do |v|
      if @dist[v.id] < min && !included?(v)
        min = @dist[v.id]
        vertex = v
      end
    end
    vertex
  end
end
