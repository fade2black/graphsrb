require 'graphsrb'
require_relative '../PrimMST/prim'
include Graphsrb

# Consider a graph G and a spanning tree T of the graph G.
# +Fundamental circuit+ is a circuit created by adding and edge to T.
# The fundamental curcuits form a basis for all circuits in the graph.

# Computes the set of fundamental circuits with
# respect to a spanning tree
module FundCircuits
  def self.run(graph)
    edges = PrimMST.run(graph)
    #Create a spanning tree
    @spanning_tree = Graph.new
    edges.each{|e| @spanning_tree.add_edge(e.initial_vertex.id, e.terminal_vertex.id)}
    cotree = graph.edges - edges

    puts "Spanning tree:"
    puts @spanning_tree.edges
    puts "-"*25

    fcs = []
    #Computes fundamental circuits
    #as sequences of vertices
    cotree.each{|e| fcs << compute_path(e.initial_vertex, e.terminal_vertex)}
    #Returns array of arrays of vertices
    return fcs
  end

  def self.compute_path(from, to)
    @target = to
    @stack = [from]
    @visited = []
    dfs(from)
    return @stack
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
end
