# Graphsrb

Graphsrb allows to create simple directed and undirected graphs. By default weight of an edge is equal to one. Basic operations allows easily implement graph algorithms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphsrb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphsrb

## Usage
```
require 'graphsrb'
include Graphsrb
```
### Creating graphs
Each vertex of a graph must have a unique id (a positive integer). Each edge is characterized by a pair of vertices `initial_vertex` and `terminal_vertex`.      
```
# (undirected) complete graph on 3 vertices
graph = Graph.new(edges:[[1,2],[2,3],[3,1]])
graph.vertex_count # => 3
graph.edge_count # => 3
graph.edge?(1,3) # => true
graph.edge?(3,1) # => true

```
```
# directed graph on 3 vertices
graph = Digraph.new(edges:[[1,2],[2,3],[3,1]])
graph.vertex_count # => 3
graph.edge_count # => 3
graph.edge?(3,1) # => false
graph.edge?(1,3) # => false
```
### Basic operations
#### Undirected graphs
```
graph = Graph.new
graph.add_edge(1,2)
v1 = Vertex.new(1)
v2 = Vertex.new(2)
edge1 = graph.edge(v1, v2)
edge1.initial_vertex.id # => 1
edge1.terminal_vertex.id # => 2
edge2 = graph.edge(v2, v1)
edge1 == edge2 # => true
```

```
# create a graph by specifying weight of each edge
graph = Graph.new(edges:[[1,2,1],[2,3,2],[3,1,3],[1,4,-1]])
v1 = Vertex.new(1)
v2 = Vertex.new(2)
graph.edge(v1, v2).weight # => 1

graph.edges.each do |edge|
  puts edge
end
# output
# (1, 2, weight:1)
# (1, 4, weight:-1)
# (2, 3, weight:2)
# (3, 1, weight:3)

graph.vertices.each do |v|
 puts "deg(#{v}) = #{graph.degree(v)}"
end
# output
# deg(1) = 3
# deg(2) = 2
# deg(3) = 2
# deg(4) = 1

graph.adjacent_vertices(v).each do |v|
 puts v
end
# output
# 2
# 4
# 3
```

```
graph = Graph.new(edges:[[1,2,1],[2,3,2],[3,1,3],[1,4,-1]])
v1 = Vertex.new(1)
v3 = Vertex.new(3)
graph.remove_edge(v1, v3)
graph.edges.each do |edge|
 puts edge
end
# output
# (1, 2, weight:1)
# (1, 4, weight:-1)
# (2, 3, weight:2)

graph.add_edge(1,3, weight:3)
graph.edges.each do |edge|
 puts edge
end
# output
# (1, 2, weight:1)
# (1, 4, weight:-1)
# (1, 3, weight:3)
# (2, 3, weight:2)

graph.remove_vertex(v1)
graph.vertex_count # => 3
graph.edge_count # => 1
graph.edge?(2,3) # => true
graph.edge?(1,3) # => false
```

```
graph = Graph.new(edges:[[1,2,1],[2,3,2],[3,1,3],[1,4,-1]])
v1 = Vertex.new(1)
v3 = Vertex.new(3)
graph.edge(v1, v3).weight # => 3
graph.update_weight(v1, v3, 5)
graph.edge(v1, v3).weight # => 5
# increase the weight of the edge (v1,v3) by 2 units
graph.increase_weight(v1, v3, 2)
graph.edge(v1, v3).weight # => 7
```

#### Directed graphs
```
# unlike undirected graphs digraph have directed edges
e1 = DiEdge.new(1,2)
e2 = DiEdge.new(2,1)
e1 == e2 # => false
```
```
graph = Digraph.new
graph.add_edge(1,2)
v1 = Vertex.new(1)
v2 = Vertex.new(2)
edge1 = graph.edge(v1, v2)
edge1.initial_vertex.id # => 1
edge1.terminal_vertex.id # => 2
edge2 = graph.edge(v2, v1) #= nil
```
```
graph = Digraph.new(edges:[[1,2,1],[2,3,2],[3,1,3],[1,4,-1]])
v1 = Vertex.new(1)

graph.indegree(v1) # => 1
graph.outdegree(v1) # => 2

graph.outgoing_edges(v1).each do |edge|
 puts edge
end
# output
# (1, 2, weight:1)
# (1, 4, weight:-1)

graph.incoming_edges(v1).each do |edge|
 puts edge
end
# output
# (3, 1, weight:3)
```
### Implementation of Algorithms
#### Backedges
```
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
        @forest << @graph.edge(v, u)
        dfs(u)
      end
    end
  end
end

edges = [
  [1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],
  [2,5],[2,6],[2,8],
  [3,4],[3,7],
  [9,10],[9,13],
  [10,11],[10,12],[10,13],
  [11,12]
]
forest = BackEdges.run(Graph.new(edges:edges))
bedges = graph.edges - forest
puts "Back edges:"
bedges.each{|edge| puts edge}
```
#### Max-flow (Edmonds-Karp algorithm)
```
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
```
**See examples (folder) for other implementations.**

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/graphsrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Graphsrb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/graphsrb/blob/master/CODE_OF_CONDUCT.md).
