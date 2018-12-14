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

      # puts block1
      # puts "*"*20
      # puts block2
      # puts "-"*20
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


def main

  # edges = [
  #   [1,2],[1,3],[1,5],
  #   [2,4],[2,5],
  #   [3,4],[3,5],
  #   [4,5]
  # ]

  edges = [[1,2],[2,3],[3,4],[4,1]]

  fcs = FundCutset.run(Graph.new(edges:edges))
  puts "\nFundamental cut set:"
  fcs.each{|cs| puts cs; puts ''}
end

main
