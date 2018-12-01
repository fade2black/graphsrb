require 'graphsrb'
include Graphsrb

module BackEdges
  def self.run(graph)
    init(graph)
    @graph.vertices.each do |v|
      dfs(v) if @dfi[v.id] == 0
    end
    @forest
  end


  def self.init(graph)
    @graph = graph
    @forest = []
    @index = 1
    @dfi = []

    @graph.vertices.each do |v|
      @dfi[v.id] = 0
    end
  end

  def self.dfs(v)
    @dfi[v.id] = @index
    @index += 1

    vertices = @graph.adjacent_vertices(v)
    vertices.each do |u|
      if @dfi[u.id] == 0
        puts "ADDING #{@graph.edge(v, u)}"
        @forest << @graph.edge(v, u)
        dfs(u)
      end
    end
  end
end
