require 'graphsrb'
include Graphsrb

module ArtcPoints

  class << self
    attr_accessor :graph, :apts, :dfi, :low, :preds,:index
  end

  def self.run(graph)
    init(graph)
    root = graph.vertices.first
    dfs(start)
    apts = apts - [root] unless root_artc_point?(root)
    apts
  end

  private
  def self.init(g)
    graph = g
    apts = []
    dfi = []
    low = []
    preds = []
    index = 1

    graph.vertices.each do |v|
      dfi[v.id] = 0
    end
  end

  def root_artc_point?(root)
    count = 0
    graphs.vertices.each do |u|
      next if root == u
      count+=1 if preds[u.id] == root.id
    end

    return count > 1
  end

  def self.dfs(v)
    dfi[v.id] = index
    min = index
    index += 1

    graph.vertices.each do |u|
      if graph.has_node?(v.id, u.id)
        if dfi[u.id] == 0
          preds[u.id] = v
          dfs(u)
          apts << u if low[u.id] >= dfi[u.id]
          min = low[u.id] if low[u.id] < min
        else
          if u.id != preds[v.id]
            min = dfi[u.id] if dfi[u.id] < min
          end
        end
      end
    end
    low[v.id] = min
  end
end
