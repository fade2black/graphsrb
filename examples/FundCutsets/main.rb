require_relative 'fund_cutsets'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  FundCutset.run(graph)
end

def main
  edges = [
    [1,2],[1,3],[1,5],
    [2,4],[2,5],
    [3,4],[3,5],
    [4,5]
  ]
  fcs = run_example('Example 1', Graph.new(edges:edges))
  puts "The fundamental cut set:"
  fcs.each{|c| puts c; puts ''}

  edges = [[1,2],[2,3],[3,4],[4,1]]
  fcs = run_example('Example 2', Graph.new(edges:edges))
  puts "The fundamental cut set:"
  fcs.each{|c| puts c; puts ''}
end

main
