require 'graphsrb'
include Graphsrb

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


def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  apts = ArtcPoints.run(graph)
  puts "Articulation points:"
  apts.each{|v| puts v}
end

def main
  edges = [
    [1,2],[1,8],
    [2,3],[2,7],
    [3,4],
    [4,5],[4,7],[4,6],
    [5,6],
    [7,8]
  ]
  run_example('Example 1', Graph.new(edges:edges))

  edges = [
    [1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],
    [2,5],[2,6],[2,8],
    [3,4],[3,7]
  ]
  run_example('Example 2', Graph.new(edges:edges))

  edges = [
    [9,10],[9,13],
    [10,11],[10,12],[10,13],
    [11,12]
  ]
  run_example('Example 3', Graph.new(edges:edges))

  edges = [[1,2], [2,3], [3,4]]
  run_example('Example 4', Graph.new(edges:edges))

  edges = [
    [1,2],[1,3],
    [2,3],
    [3,4],[3,5],
    [4,5]
  ]
  run_example('Example 5', Graph.new(edges:edges))

  edges = [[1,2], [2,3], [3,4], [4,1]]
  run_example('Example 6', Graph.new(edges:edges))
end

main
