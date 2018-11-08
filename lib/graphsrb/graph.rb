
#This class is the base clase for undirected and directed graphs. Each vertex is represented as a single non-negative integer.
#Each edge is represented by a triple [v_1, v_2, weight].
class Graphsrb::Graph

  #Create a graph from +vertices+ and +edges+. Vertices are given as an array of integers.
  #Edges are given as an array of tripples [v_1, v_2, weight].
  #
  #<b>Example:</b>
  #   graph = Graphsrb::Graph.new(vertices: [1,2,3], edges:[[1,2,1], [2,3,1], [2,1,1]])

  def initialize(args={})
    raise Graphsrb::VertexInitializationError, 'Missing vertices' if args[:vertices].nil?

    @adj_table = {}
    args[:vertices].each{|vertex_id| adj_table[vertex_id] = _create_adjacency_list }
    args[:edges].each do |e|
      unless has_edge?(e[0], e[1])
        add_edge(e[0], e[1], weight: e[2] || 1)
      end
    end
  end

  #Returns vertices of the graph
  def vertices
    adj_table.keys
  end
  #Removes all vertices and edges.
  def clear
    adj_table.each_value{|list| list.clear}
  end

  ##Creates a copy of the graph
  def copy
    Marshal::load(Marshal.dump(self))
  end

  #Returns the number of vertices
  def vertex_count
    vertices.size
  end

  #Returns the number of edges in the graph
  def edge_count
    sum = 0
    adj_table.each_value{|list| sum += list.size}
    sum
  end

  #Checks whether the graph has a vertex
  def has_vertex?(id)
    not adj_table[id].nil?
  end

  #Checks whether the graph has an edge (v_1, v_2).
  def has_edge?(id1, id2)
    has_vertex?(id1) && adj_table[id1].has_node?(_create_node(id2)) ||
    has_vertex?(id2) && adj_table[id2].has_node?(_create_node(id1))
  end

  #Adds a new vertex
  def add_vertex(id)
    adj_table[id] = _create_adjacency_list
  end

  #Adds a new edge
  def add_edge(id1, id2, args={})
    return if has_edge?(id1, id2)
    add_vertex(id1) unless has_vertex?(id1)
    add_vertex(id2) unless has_vertex?(id2)
    adj_table[id1] << _create_node(id2, args)
  end

  #Remove an edge from the graph
  def remove_edge(id1, id2)
    adj_table[id1].delete(_create_node(id2)) if has_vertex?(id1)
    adj_table[id2].delete(_create_node(id1)) if has_vertex?(id2)
  end

  #Remove a vertex from the graph
  def remove_vertex(id)
    return unless has_vertex?(id)

    adj_table[id].clear
    adj_table.delete(id)

    node = _create_node(id)
    adj_table.each_value{|list| list.delete(node)}
  end

  #Retrieves an edge
  def edge(id1, id2)
    if has_vertex?(id1)
      node = adj_table[id1].find(_create_node(id2))
      return _create_edge(id1, id2, weight:node.weight) if node
    end

    if has_vertex?(id2)
      node = adj_table[id2].find(_create_node(id1))
      return _create_edge(id1, id2, weight:node.weight) if node
    end
  end


  #Retrieves all incident edges of a vertex
  #Returns an array of tripples *[vertex_1, vertex_2, weight]*
  def incident_edges(id)
    nodes = []
    nodes = adj_table[id].nodes unless adj_table[id].nil?
    vertices.each do |v|
      next if v == id
      node = adj_table[v].find(_create_node(id))
      nodes << _create_node(v, weight:node.weight) unless node.nil?
    end
    #Convert node into edges with weights
    nodes.map{|node| _create_edge(id, node.vertex.id, weight:node.weight)}
  end


  protected
  attr_reader :adj_table


  private
  def _create_node(vertex_id, args={})
    Graphsrb::Node.new(vertex_id, args)
  end

  def _create_adjacency_list
    Graphsrb::AdjacencyList.new
  end

  def _create_edge(id1, id2, args={})
    Graphsrb::Edge.new(id1, id2, args)
  end

end
