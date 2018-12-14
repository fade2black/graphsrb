require 'graphsrb'
require_relative '../../PrimMST/prim'
include Graphsrb

# 2-approximation for TSP
module ApproxAlgs
  module TSP
    def self.run(graph)
      edges = PrimMST.run(graph)
      #Create a spanning tree
      @spanning_tree = Graph.new
      edges.each{|e| @spanning_tree.add_edge(e.initial_vertex.id, e.terminal_vertex.id)}

      puts "Spanning tree:"
      puts @spanning_tree.edges
      puts "-"*25
      compute_path(edges.first.initial_vertex)
    end

    def self.compute_path(start)
      @stack = [start]
      @visited = []
      dfs(start)
      return @stack.uniq
    end

    def self.dfs(v)
      @stack.push(v)
      @visited[v.id] = true
      @spanning_tree.adjacent_vertices(v).each do |v|
        dfs(v) if !@visited[v.id]
      end
    end
  end
end

edges = [
  [1,2,6], [1,3,3], [1,4,5],[1,5,5],
  [2,3,4], [2,4,4], [2,5,2],
  [3,4,3], [3,5,4],
  [4,5,4]
]


puts ApproxAlgs::TSP.run(Graph.new(edges:edges))
