require 'graphsrb'
include Graphsrb

#Computes articulation points
module ArtcPoints
  def self.run(g)
    init(g)
    root = @graph.vertices.first
    dfs(root)
    @apts = @apts - [root]
    @apts << root if root_artc_point?(root)
    @apts
  end

  def self.init(g)
    @graph = g
    @apts = []
    @dfi = []
    @low = []
    @preds = []
    @index = 1

    @graph.vertices.each do |u|
      @dfi[u.id] = 0
    end
  end

  def self.root_artc_point?(root)
    count = 0
    @graph.vertices.each do |u|
      next if root == u
      count+=1 if @preds[u.id] == root.id
    end

    return count > 1
  end

  def self.dfs(v)
    @dfi[v.id] = @index
    min = @index
    @index += 1

    @graph.vertices.each do |u|
      if @graph.has_edge?(v.id, u.id)
        if @dfi[u.id] == 0
          @preds[u.id] = v.id
          dfs(u)
          @apts << v if @low[u.id] >= @dfi[v.id]
          min = @low[u.id] if @low[u.id] < min
        else #found a backedge
          if u.id != @preds[v.id]
            min = @dfi[u.id] if @dfi[u.id] < min
          end
        end
      end
    end
    @low[v.id] = min
  end
end
