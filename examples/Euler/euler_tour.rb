require 'graphsrb'
include Graphsrb

#Assumption: graph is nonempty connected undirected and all vertices have even degree
module EulerTour
  def self.run(graph)
    init(graph)
    dfs(graph.vertices.first)
    return @circuit.reverse
  end

  def self.init(g)
    @graph = g
    @circuit = []
    @stack = []
  end

  def self.dfs(v)
    vertices = @graph.adjacent_vertices(v)
    #If current vertex has no neighbors then
    #add it to circuit, remove the last vertex from the stack
    #and move to this vertex
    if vertices.size == 0
      @circuit << v
      dfs(@stack.pop) unless @stack.empty?
    else
      #Add the vertex to the stack,
      #take any of its neighbors u, remove the edge (v,u),
      # and move to the vertex u.
      @stack.push(v)
      u = vertices.first
      @graph.remove_edge(v, u)
      dfs(u)
    end
  end
end
