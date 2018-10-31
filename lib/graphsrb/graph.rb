
module Graphsrb
  ##
  #This class is the base for undirected and directed graphs. Each vertex is represented as a single non-negative integer.
  #Each edge is represented by a triple [v_1, v_2, weight].
  class Graph
    attr_reader :vertices, :edges, :adj_list

    ##
    #Create a graph from +vertices+ and +edges+. Vertices are given as an array of integers.
    #Edges are given as array of tripples [v_1, v_2, weight].
    def initialize(args={})
      @vertices = args[:vertices].clone
      raise Graphsrb::VertexInitializationError, 'Missing vertices' if @vertices.nil?
      @adj_list = {}
      @vertices.each{|v| @adj_list[v] = []}
      args[:edges].each {|e| @adj_list[e[0]] << e[1] unless has_edge?(e)}
    end



    private



  end
end
