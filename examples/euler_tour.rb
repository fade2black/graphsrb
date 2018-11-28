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


def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  tour = EulerTour.run(graph)
  puts "Euler tour:"
  tour.each{|v| puts v}
end

def main
  edges = [[1,2],[2,3],[3,4],[4,1]]
  run_example('Example 1', Graph.new(edges:edges))

  edges = [[1,2],[2,3],[3,4],[4,1],[2,7],[2,5],[7,6],[5,6]]
  run_example('Example 2', Graph.new(edges:edges))
end

main
