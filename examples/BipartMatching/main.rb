require_relative 'bipart_matching'

def run_example(example_title, graph, part1)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  puts "Size of max bipartite matching: #{BipartiteMatching.run(graph, part1)}"
end

def main

  edges = [
    [1,2],
    [3,2], [3,6],
    [5,4], [5,6], [5,8],
    [7,6],
    [9,6]
  ]
  part1 = []
  [1,3,5,7,9].each{|id| part1 << Vertex.new(id)}
  run_example('Example 1', Graph.new(edges:edges), part1)


  edges = [
    [1,2],
    [3,4],
    [5,6],
    [7,8]
  ]
  part1 = []
  [1,3,5,7].each{|id| part1 << Vertex.new(id)}
  run_example('Example 2', Graph.new(edges:edges), part1)

  edges = [
    [1,2],
    [3,2],
    [5,2],
    [7,2]
  ]
  part1 = []
  [1,3,5,7].each{|id| part1 << Vertex.new(id)}
  run_example('Example 3', Graph.new(edges:edges), part1)


  edges = [
    [1,7],
    [2,6],
    [3,8],
    [4,7],
    [5,9],
    [10,8]
  ]
  part1 = []
  [1,2,3,4,5,10].each{|id| part1 << Vertex.new(id)}
  run_example('Example 4', Graph.new(edges:edges), part1)

end

main
