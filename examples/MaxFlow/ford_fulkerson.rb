require 'graphsrb'
include Graphsrb

module FordFulkerson
  def self.run(graph, s, t)
    init(graph)
    while(true)
      path = find_path(s, t)
      break if path.empty?
      
    end

  end

  def self.init(graph)
    @graph = graph
    @res_graph = Digraph.new

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
