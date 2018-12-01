require 'graphsrb'
require_relative '../PrimMST/prim'
include Graphsrb

module FundCircuits
  def self.run(graph)
    init(graph)
    edges = PrimMST.run(graph)
    #Create a spanning tree
    @spanning_tree = Graph.new
    edges.each{|e| @spanning_tree.add_edge(e.initial_vertex, e.terminal_vertex)}
    cotree = graph.edges - edges
    puts cotree
    compute_path(Vertex.new(2),Vertex.new(3))
    puts @statck
    #compute_path()
  end

  def self.compute_path(from, to)
    @target = to
    @stack = [from]
    @visited = []
    dfs(from)
  end

  def self.dfs(v)
    @visited[v.id] = true
    @spanning_tree.adjacent_vertices(v).each do |v|
      @stack.push(v)
      return true if v == @target
      return true if !@visited[v.id] && dfs(v)
      @stack.pop
    end
    false
  end

  def self.init(g)
    @graph = g
  end
end


def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  FundCircuits.run(graph)
end

def main
  edges = [
    [1,2],[1,3],[1,4],
    [2,3],[2,5],[2,5],
    [3,4],[3,5]
  ]
  run_example('Example 1', Graph.new(edges:edges))
end

main
