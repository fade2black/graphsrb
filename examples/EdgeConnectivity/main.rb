require_relative 'econ'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  puts "Edge connectivity is #{EdgeConnectivity.run(graph)}"
end

def main
  edges = [
    [1,2], [1,3], [1,5],
    [2,4], [2,5], [2,6],
    [3,4], [3,6],
    [4,5], [4,6],
    [5,6]
  ]
  run_example('Example 1', Graph.new(edges:edges))

  edges = [
    [1,2], [1,3],
    [2,4],
    [3,4],
    [4,5],
    [5,6], [5,6],
    [6,7]
  ]
  run_example('Example 2', Graph.new(edges:edges))

  edges = [[1,2],[2,3],[3,4],[4,1],[1,3],[4,2]]
  run_example('Example 3', Graph.new(edges:edges))

end

main
