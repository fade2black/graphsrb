require_relative 'artc_points'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  apts = ArtcPoints.run(graph)
  puts "Articulation points:"
  apts.each{|v| puts v}
end

def main
  edges = [
    [1,2],[1,8],
    [2,3],[2,7],
    [3,4],
    [4,5],[4,7],[4,6],
    [5,6],
    [7,8]
  ]
  run_example('Example 1', Graph.new(edges:edges))

  edges = [
    [1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],
    [2,5],[2,6],[2,8],
    [3,4],[3,7]
  ]
  run_example('Example 2', Graph.new(edges:edges))

  edges = [
    [9,10],[9,13],
    [10,11],[10,12],[10,13],
    [11,12]
  ]
  run_example('Example 3', Graph.new(edges:edges))

  edges = [[1,2], [2,3], [3,4]]
  run_example('Example 4', Graph.new(edges:edges))

  edges = [
    [1,2],[1,3],
    [2,3],
    [3,4],[3,5],
    [4,5]
  ]
  run_example('Example 5', Graph.new(edges:edges))

  edges = [[1,2], [2,3], [3,4], [4,1]]
  run_example('Example 6', Graph.new(edges:edges))
end

main
