require_relative 'fund_circuits'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  FundCircuits.run(graph)
end

def main
  edges = [
    [1,2],[1,3],[1,4],
    [2,3],[2,4],[2,5],
    [3,4],[3,5]
  ]
  fcs = run_example('Example 1', Graph.new(edges:edges))
  fcs.each{|c| puts c; puts ''}

  edges = [
    [1,2],[1,5],[1,4],
    [2,3],[2,5],[2,6],
    [3,5],[3,6],
    [4,5],
    [5,6]
  ]
  fcs = run_example('Example 2', Graph.new(edges:edges))
  fcs.each{|c| puts c; puts ''}

  edges = [
    [1,2],[3,2],[3,4],[4,1]]
  fcs = run_example('Example 3', Graph.new(edges:edges))
  fcs.each{|c| puts c; puts ''}
end

main
