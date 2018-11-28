require 'graphsrb'
include Graphsrb

#Assumption: graph is connected undirected and all vertices have even degree
module EulerTour
  def self.run(graph)
    init(graph)
    dfs(v)
  end

  def self.init(g)
    @graph = g
    @circuit = []
    @stack = []
  end

  def dfs(v)
    #If current vertex has no neighbors - add it to circuit
    if @graph.degree(v)
  end

end