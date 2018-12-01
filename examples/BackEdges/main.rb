require_relative 'backedges'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  #Compute forest edges using depth first search algorithm
  forest = BackEdges.run(graph)
  puts graph.edges
  puts "------------"
  puts forest
  return
  puts "Forest:"
  forest.each{|edge| puts edge}
  #Compute back edges
  bedges = graph.edges - forest
  puts "Back edges:"
  bedges.each{|edge| puts edge}
end

def main
  # edges = [
  #   [1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],
  #   [2,5],[2,6],[2,8],
  #   [3,4],[3,7],
  #   [9,10],[9,13],
  #   [10,11],[10,12],[10,13],
  #   [11,12]
  # ]
  # run_example('Example 1 (undirected graph)', Graph.new(edges:edges))

  diedges = [
    [1,3],[1,5],
    [2,1],
    [3,2],
    [4,3],
    [5,4],[5,6],
    [6,4],
    [7,8],[7,9],
    [9,6],[9,8]
  ]

  run_example('Example 2 (directed graph)', Digraph.new(edges:diedges))
end

main
