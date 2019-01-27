require_relative 'mis'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  MIS.run(graph)
end

def main
  edges = [[1,2]]
  mis = run_example('Example 1', Graph.new(edges:edges))
  puts mis

  edges = [[1,2],[2,3]]
  mis = run_example('Example 2', Graph.new(edges:edges))
  puts mis

  edges = [[1,2],[2,3],[3,4]]
  mis = run_example('Example 3', Graph.new(edges:edges))
  puts mis


  edges = [[1,2],[1,3],[1,4]]
  mis = run_example('Example 4', Graph.new(edges:edges))
  puts mis

  edges = [[1,2],[2,3],[3,4],[4,1],
           [5,6],[6,7],[7,8],[8,5],
           [1,5],[2,6],[8,4],[7,3]
  ]
  mis = run_example('Example 5', Graph.new(edges:edges))
  puts mis

  mis = run_example('Example 6', Graph.new(vertices:[1]))
  puts mis

  mis = run_example('Example 7', Graph.new(vertices:[1,2,3,4,5]))
  puts mis

  edges = [[1,2],[1,3],[1,4],
           [2,3],[2,4],
           [3,4]
  ]
  mis = run_example('Example 8', Graph.new(edges:edges))
  puts mis

  edges = [[1,2],[2,3],[3,4],[1,4]]
  mis = run_example('Example 9', Graph.new(edges:edges))
  puts mis

  edges = [[1,2],[2,3],[3,4],[4,5],[5,1],[4,1]]
  mis = run_example('Example 10', Graph.new(edges:edges))
  puts mis
end

main
