require 'graphsrb'
include Graphsrb

#Assumption: graph is nonempty connected undirected
module PrimMST
  INF = (2**(0.size * 8 -2) -1)

  def self.run(graph)
    init(graph)
    vertices = graph.vertices

    start = vertices.first
    @parent[start.id] = nil
    include_vertex(start)

    edges = graph.incident_edges(start)
    edges.each{|edge| @dist[v.id] = edge.weight }

    while not all_vertices_included?
      v = min_dist_vertex
      include_vertex(v)
      update_distances(v)
    end

    edges = []
    (1...@parents.size).each do |i|
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
      if not included?(u) && (@dist[u] > edge.weight)
        @dist[u] = edge.weight
        @parent[u.id] = v
      end
    end
  end

  def self.all_vertices_included?
    @included_vertex_count == @vertex_count
  end

  def self.min_dist_vertex
    min = INF
    @graph.vertices.each do |v|
      if @dist[v.id] < min && !included?(v)
        min = @dist[v.id]
        vertex = v
      end
    end
    vertex
  end
end

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  edges = PrimMST.run(graph)
  puts "MST:"
  edges.each{|v| puts v}
end

def main
  edges = [
    [1,2,19],[1,3,17],[1,5,5],
    [2,4,13],[2,5,2], [2,6,7],
    [3,4,3], [3,6,17],
    [4,5,10],[4,6,14],
    [5,6,9]
  ]
  run_example('Example 1', Graph.new(edges:edges))
end

main
