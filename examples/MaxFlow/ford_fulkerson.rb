require 'graphsrb'
include Graphsrb

module FordFulkerson
  def self.run(graph, s, t)
    init(graph)
    while(true)
      vertices = find_path(s, t)
      break if path.empty?
      update_residual_graph(vertices)
    end

  end

  def self.update_residual_graph(vertices)
    #find min increase
    min_val = @res_graph.edge(vertices[0], vertices[1]).weight
    (1...vertices.size-1).each do |i|
      val = @res_graph.edge(vertices[i], vertices[i+1]).weight
      min_val = val if val < min_val
    end
    #update
    (0...path.size-1).each do |i|
      u,v = vertices[i], vertices[i+1]
      if @graph.edge?(u,v)
        weight = @res_graph.edge(u,v).weight
        @res_graph.update_weight(u,v, weight + min_val)
      else
        weight = @res_graph.edge(v,u).weight
        @res_graph.update_weight(v,u, weight - min_val)
      end
    end

  end

  def self.init(graph)
    @graph = graph
    @res_graph = Digraph.new
    #Initially sets weights
    #of the residual graph to zero
    @graph.edges.each do |edge|
      @graph.update_weight(edge.initial_vertex, edge_terminal_vertex, 0)
    end
  end
end


edges = [
  [1,2,6], [1,3,3], [1,4,5],[1,5,5],
  [2,3,4], [2,4,4], [2,5,2],
  [3,4,3], [3,5,4],
  [4,5,4]
]


#puts ApproxAlgs::TSP.run(Digraph.new(edges:edges))
