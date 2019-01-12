require 'graphsrb'
require_relative '../MaxFlow/edmonds_karp'
include Graphsrb


module BipartiteMatching
  def self.run(graph, part1)
    init(graph, part1)
    EdmondsKarp.run(@graph, @source, @target)
  end

  def self.init(graph, part1)
    @graph = Digraph.new
    max_id = graph.vertices.map{|v| v.id}.max

    @source = Vertex.new(max_id + 1)
    @target = Vertex.new(max_id + 2)

    @graph.add_vertex(@source.id)
    @graph.add_vertex(@target.id)

    graph.edges.each do |e|
      u,v = e.initial_vertex, e.terminal_vertex
      u,v = v,u unless part1.include?(e.initial_vertex)

      # source ==> u
      @graph.add_edge(@source.id, u.id, weight:1)
      # u ==> v
      @graph.add_edge(u.id, v.id, weight:1)
      # v ==> target
      @graph.add_edge(v.id, @target.id, weight:1)
    end
  end
end
