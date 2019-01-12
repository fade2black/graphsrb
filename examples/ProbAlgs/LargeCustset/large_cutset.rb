require 'graphsrb'
include Graphsrb

# The problem is finding a large cutset in
# a simple undirected graph where each edge
# has weigh equal to 1.
# This problem is NP-hard.
module LargeCutset

  def self.run(graph)
    init(graph)
    compute_cut
  end

  def self.init(graph)
    @graph = graph
    @pA, @pB = [], []
  end

  #Monte Carlo algorithm
  def self.compute_cut
    prng = Random.new(Time.now.to_i)
    @graph.vertices.each do |v|
      if prng.rand(100) < 50
        @pA << v
      else
        @pB << v
      end
    end
    cut_weight
  end

  def self.cut_weight
    total_weight = 0
    @pA.each do |v|
      @graph.adjacent_vertices(v).each do |u|
        total_weight += 1 if @pB.include?(u)
      end
    end
    total_weight
  end

  def self.print_cutset
    puts "Cutset:"
    @pA.each do |v|
      @graph.adjacent_vertices(v).each do |u|
        puts @graph.edge(v,u) if @pB.include?(u)
      end
    end
  end

  def self.print_partitions
    print "Partition A: "
    @pA.each{|v| print "#{v} "}
    print "\nPartition B: "
    @pB.each{|v| print "#{v} "}
    print "\n"
  end
end
