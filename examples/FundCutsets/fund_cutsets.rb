require 'graphsrb'
require_relative '../PrimMST/prim'
include Graphsrb

module FundCutset
  def self.run(graph)
    edges = PrimMST.run(graph)
    #Create a spanning tree
    @spanning_tree = Graph.new
    edges.each{|e| @spanning_tree.add_edge(e.initial_vertex.id, e.terminal_vertex.id)}

    puts "Spanning tree:"
    puts @spanning_tree.edges
    puts "-"*25

    # Compute fundamental cut-sets
    fcs = []
    edges.each do |e|
      @spanning_tree.remove_edge(e.initial_vertex, e.terminal_vertex)
      block1 = compute_block(e.initial_vertex)
      block2 = compute_block(e.terminal_vertex)

      cut_set = []
      block1.each do |v|
        block2.each do |u|
          edge = graph.edge(v,u)
          cut_set << edge if edge
        end
      end
      @spanning_tree.add_edge(e.initial_vertex.id, e.terminal_vertex.id)
      fcs << cut_set
    end
    return fcs
  end

  def self.compute_block(v)
    @block = []
    @visited = []
    dfs(v)
    return @block
  end

  def self.dfs(v)
    @visited[v.id] = true
    @block.push(v)
    @spanning_tree.adjacent_vertices(v).each do |v|
      dfs(v) unless @visited[v.id]
    end
  end
end
