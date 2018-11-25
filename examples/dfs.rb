module DFS
  def self.init(graph)
    @graph = graph
    @forest = []
    @index = 1
    @dfi = []

    @graph.vertices.each do |v|
      @dfi[v.id] = 0
    end
  end

  def self.run(graph)
    init(graph)
    @graph.vertices.each do |v|
      dfs(@graph.vertices.first) if @dfi[v.id] == 0
    end
    @forest
  end

  private

  def self.dfs(v)
    @dfi[v.id] = @index
    @index += 1

    vertices = @graph.adjacent_vertices(v)
    vertices.each do |u|
      if @dfi[u.id] == 0
        @forest << @graph.edge(v.id, u.id)
        dfs(u)
      end
    end
  end
end
