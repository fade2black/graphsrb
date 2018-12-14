require_relative 'vertex_cover'

def run_example(example_title, graph)
  puts "------- #{example_title} ------ "
  puts "The graph has #{graph.vertex_count} vertices and #{graph.edge_count} edges"
  ApproxAlgs::VertexCover.run(graph)
end


def main
  edges = [
    [1,2],[1,4],
    [2,3],[2,5],
    [3,5],[3,6],[3,7],
    [5,6]
  ]
  vertices = run_example('Example 1', Graph.new(edges:edges))
  vertices.each {|v| puts v}


  edges = [[1,2],[2,3],[3,4],[4,5]]
  vertices = run_example('Example 2', Graph.new(edges:edges))
  vertices.each {|v| puts v}

  edges = [[1,2],[3,4],[5,6],[7,8]]
  vertices = run_example('Example 3', Graph.new(edges:edges))
  vertices.each {|v| puts v}

  edges = [[1,2],[1,3],[1,4],[1,5]]
  vertices = run_example('Example 4', Graph.new(edges:edges))
  vertices.each {|v| puts v}
end

main
