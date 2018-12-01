require_relative 'prim'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  edges = PrimMST.run(graph)
  puts "MST:"
  edges.each{|e| puts e}
  puts "MST value: #{edges.inject(0){|s, e| s + e.weight}}"
end

def main
  edges = [
    [1,2,19],[1,3,17],[1,5,5],
    [2,4,13],[2,5,2], [2,6,7],
    [3,4,3], [3,6,17],
    [4,5,10],[4,6,14],
    [5,6,9]
  ]
  run_example('Example 1', Graph.new(edges:edges))

  edges = [
    [1,2,1], [1,3,3], [1,4,4],
    [2,3,2],
    [3,4,5]
  ]
  run_example('Example 2', Graph.new(edges:edges))

  edges = [
    [1,2,1], [1,3,7],
    [2,3,5], [2,4,3], [2,5,4],
    [3,4,6],
    [4,5,2]
  ]
  run_example('Example 3', Graph.new(edges:edges))

  edges = [
    [1,2,7], [1,4,6],
    [2,3,6],
    [4,2,9], [4,3,8]
  ]
  run_example('Example 4', Graph.new(edges:edges))

end

main
