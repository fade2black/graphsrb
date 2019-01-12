require_relative 'edmonds_karp'

def run_example(example_title, graph, s, t)
  puts "------- #{example_title} ------ "
  puts "Max flow: #{EdmondsKarp.run(graph, s, t)}"
  puts "Flow graph:"
  EdmondsKarp.print_flow
end

def main
  edges = [
    [1,2,16], [1,3,13],
    [2,4,12],
    [3,2,4], [3,5,14],
    [4,3,9], [4,6,20],
    [5,4,7], [5,6,4]
  ]
  run_example("Example 1", Digraph.new(edges:edges), Vertex.new(1), Vertex.new(6))

  edges = [
    [1,2,3],[1,3,2],
    [2,3,2],[2,4,4],
    [3,6,6],
    [4,5,3],[4,3,2],
    [5,6,1]
  ]
  run_example("Example 2", Digraph.new(edges:edges), Vertex.new(1), Vertex.new(6))

  edges = [
    [1,2,10], [1,3,8],
    [2,3,2], [2,4,5],
    [3,5,10],
    [4,6,7],
    [5,4,8], [5,6,10]
  ]
  run_example("Example 3", Digraph.new(edges:edges), Vertex.new(1), Vertex.new(6))

  edges = [
    [1,2,10], [1,3,8],
    [2,3,2], [2,4,8],
    [3,4,6],[3,5,7],
    [4,6,10],
    [5,6,10]
  ]
  run_example("Example 4", Digraph.new(edges:edges), Vertex.new(1), Vertex.new(6))

  edges = [
    [1,2,3], [1,3,3], [1,4,4],
    [2,5,2],
    [3,2,10], [3,5,1],
    [4,6,5],
    [5,6,1], [5,7,2],
    [6,7,5]
  ]
  run_example("Example 5", Digraph.new(edges:edges), Vertex.new(1), Vertex.new(7))

  edges = [
    [1,2,38], [1,3,1], [1,4,2],
    [2,3,8],  [2,5,13],[2,6,10],
    [3,6,26],
    [4,8,27],
    [5,3,2], [5,7,1],  [5,8,7],
    [6,4,24], [6,7,8], [6,8,1],
    [7,8,7]
  ]
  run_example("Example 6", Digraph.new(edges:edges), Vertex.new(1), Vertex.new(8))

  edges = [
    [1,2],
    [2,9],
    [3,2],
    [5,2],
    [7,2],
    [8,1],[8,3],[8,5],[8,7]
  ]
  run_example("Example 7", Digraph.new(edges:edges), Vertex.new(8), Vertex.new(9))
end

main
