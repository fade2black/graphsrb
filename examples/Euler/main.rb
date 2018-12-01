require_relative 'euler_tour'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  tour = EulerTour.run(graph)
  puts "Euler tour:"
  tour.each{|v| puts v}
end

def main
  edges = [[1,2],[2,3],[3,4],[4,1]]
  run_example('Example 1', Graph.new(edges:edges))

  edges = [[1,2],[2,3],[3,4],[4,1],[2,7],[2,5],[7,6],[5,6]]
  run_example('Example 2', Graph.new(edges:edges))
end

main
