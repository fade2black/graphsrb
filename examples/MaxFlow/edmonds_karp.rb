require 'graphsrb'
include Graphsrb

module EdmondsKarp
  MAX_INT = (2**(0.size * 8 -2) -1)

  # Given undirected graph, source, and target
  # computes maximum flow value between the source and target
  def self.run(graph, s, t)
    init(graph)
    max_flow = 0
    while true
      min_val, vertices = find_path(s,t)
      break if min_val.nil?
      update_flows(vertices, min_val)
      max_flow += min_val
    end
    max_flow
  end

  def self.init(graph)
    @graph = graph

    @flow = []
    @graph.vertices.each{|v| @flow[v.id] = []}

    @graph.vertices.each do |v|
      @graph.adjacent_vertices(v).each do |u|
        @flow[v.id][u.id] = 0
      end
    end
  end

  def self.find_path(s,t)
    parent = []
    queue = [s]
    visited = []

    parent[s.id] = nil
    visited[s.id] = true

    max_id = @graph.vertices.map{|v| v.id}.max
    pushed_amount = Array.new(max_id, MAX_INT)

    while !queue.empty?
      v = queue.shift
      break if v == t
      vertices = @graph.adjacent_vertices(v)

      vertices.each do |u|
        cap = @graph.edge(v,u).weight
        flow = @flow[v.id][u.id]
        if !visited[u.id] && (cap - flow > 0)
          queue.push(u)
          visited[u.id] = true
          parent[u.id] = v
          pushed_amount[u.id] = [pushed_amount[v.id], cap - flow].min
        end
      end
    end

    return [nil, nil] if v != t

    path = [t]
    v = parent[t.id]
    while true
      path << v
      break if v == s
      v = parent[v.id]
    end

    [pushed_amount[t.id], path.reverse]
  end

  def self.update_flows(vertices, min_val)
    (0...vertices.size-1).each do |i|
      u,v = vertices[i], vertices[i+1]
      @flow[u.id][v.id] += min_val
    end
  end

  def self.print_flow
    @graph.vertices.each do |v|
      @graph.adjacent_vertices(v).each do |u|
        cap = @graph.edge(v,u).weight
        puts "(#{v.id})==#{@flow[v.id][u.id]}/#{cap}==>(#{u.id})"
      end
    end
    puts "-"*45
  end
end
