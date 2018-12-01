require_relative 'fund_circuits'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  edges = FundCircuits.run(graph)
end

def main
  edges = [
    [1,2],[1,3],[1,4],
    [2,3],[2,5],[2,5],
    [3,4],[3,5]
  ]
  run_example('Example 1', Graph.new(edges:edges))
end

main
