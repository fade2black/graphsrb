
#This class is the base clase for undirected and directed graphs.
class Graphsrb::BaseGraph

  def initialize(args={})
    @adj_table = {}
    args.fetch(:vertices,[]).each{|vertex_id| adj_table[vertex_id] = _create_adjacency_list }
    args.fetch(:edges,[]).each do |e|
      unless has_edge?(e[0], e[1])
        vertices_must_be_different!(e[0], e[1])
        add_edge(e[0], e[1], weight: e[2] || 1)
      end
    end
  end

  #Returns vertices of the graph
  def vertices
    vertex_array = []
    adj_table.keys.each do |id|
      vertex_array << _create_vertex(id)
    end
    vertex_array
  end

  #Returns edges
  def edges
    edges_array = []
    vertices.each do |vertex|
      adj_table[vertex.id].each do |node|
        edges_array << _create_edge(vertex.id, node.vertex.id, weight: node.weight)
      end
    end
    edges_array
  end

  #Removes all vertices and edges.
  def clear
    adj_table.each_value{|list| list.clear}
    @adj_table = {}
    true
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

  alias vertex? has_vertex?

  #Checks whether the graph has an edge
  def has_edge?(id1, id2)
    has_vertex?(id1) && adj_table[id1].has_node?(_create_node(id2)) ||
    has_vertex?(id2) && adj_table[id2].has_node?(_create_node(id1))
  end

  alias edge? has_edge?

  #Adds a new vertex
  def add_vertex(id)
    return nil if has_vertex?(id)
    adj_table[id] = _create_adjacency_list
    true
  end

  #Adds a new edge
  def add_edge(id1, id2, args={})
    vertices_must_be_different!(id1, id2)
    return nil if has_edge?(id1, id2)
    add_vertex(id1) unless has_vertex?(id1)
    add_vertex(id2) unless has_vertex?(id2)
    adj_table[id1] << _create_node(id2, args)
    true
  end

  #Remove an edge from the graph
  def remove_edge(id1, id2)
    adj_table[id1].delete(_create_node(id2)) if has_vertex?(id1)
    adj_table[id2].delete(_create_node(id1)) if has_vertex?(id2)
    true
  end

  #Remove a vertex from the graph
  def remove_vertex(id)
    return nil unless has_vertex?(id)

    adj_table[id].clear
    adj_table.delete(id)

    node = _create_node(id)
    adj_table.each_value{|list| list.delete(node)}
    return id
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


  protected
  attr_reader :adj_table

  def _create_node(vertex_id, args={})
    Graphsrb::Node.new(vertex_id, args)
  end

  def _create_adjacency_list
    Graphsrb::AdjacencyList.new
  end

  def _create_edge(id1, id2, args={})
    Graphsrb::Edge.new(id1, id2, args)
  end

  def _create_vertex(id)
    Graphsrb::Vertex.new(id)
  end

  def vertices_must_be_different!(id1, id2)
    if id1 == id2
      raise Graphsrb::EdgeInitializationError, "Vertex id's must be different from each other"
    end
  end

end
