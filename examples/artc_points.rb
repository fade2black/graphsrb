require 'graphsrb'
include Graphsrb

module ArtcPoints


  private
  def self.init(graph)
    @graph = graph
    @apts = []
    @dfi = []
    @low = []
    @preds = []
    @index = 1

    @graph.vertices.each do |v|
      @dfi[v.id] = 0
    end
  end

  def self.dfs(v)
    @dfi[v.id] = @index
    min = @index
    @index += 1

    @graph.vertices.each do |v|
      
    end
  end

end
