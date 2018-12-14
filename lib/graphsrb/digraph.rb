#Directed graph
class Graphsrb::Digraph < Graphsrb::BaseGraph

  #Retrieves adjacent vertices of a vertex
  def adjacent_vertices(vertex)
    nodes = []
    id = vertex.id
    nodes = adj_table[id].nodes unless adj_table[id].nil?
    #Convert nodes into vertices
    nodes.map{|node| _create_vertex(node.vertex.id)}
  end

  alias neighborhood adjacent_vertices

  #Checks whether the digraph has an edge
  def has_edge?(id1, id2)
    has_vertex?(id1) && adj_table[id1].has_node?(_create_node(id2))
  end

  #Retrieves an edge
  def edge(v, u)
    id1, id2 = v.id, u.id
    if has_vertex?(id1)
      node = adj_table[id1].find(_create_node(id2))
      return _create_edge(id1, id2, weight:node.weight) if node
    end
  end

  #Updates edge weight
  def update_weight(v, u, w)
    id1, id2 = v.id, u.id
    adj_table[id1].update_weight(_create_node(id2), w) if has_vertex?(id1)
  end


  #Remove an edge from the graph
  def remove_edge(id1, id2)
    adj_table[id1].delete(_create_node(id2)) if has_vertex?(id1)
    true
  end

  #Retrieves outgoing edges of a vertex
  def outgoing_edges(v)
    #Convert nodes into edges
    _outgoing_nodes(v.id).map{|node| _create_edge(v.id, node.vertex.id, weight:node.weight)}
  end

  #Retrieves incoming edges of a vertex
  def incoming_edges(v)
    #Convert nodes into edges
    _incoming_nodes(v.id).map{|node| _create_edge(node.vertex.id, v.id, weight:node.weight)}
  end

  #Returns +out-degree+ of a vertex
  def outdegree(v)
    _outgoing_nodes(v.id).size
  end

  #Returns +in-degree+ of a vertex
  def indegree(v)
    _incoming_nodes(v.id).size
  end

  private

  def _outgoing_nodes(id)
    nodes = []
    nodes = adj_table[id].nodes unless adj_table[id].nil?
    nodes
  end

  def _incoming_nodes(id)
    nodes = []
    vertices.each do |vertex|
      next if vertex.id == id
      node = adj_table[vertex.id].find(_create_node(id))
      nodes << _create_node(vertex.id, weight:node.weight) unless node.nil?
    end
    nodes
  end

  protected
  def _create_edge(id1, id2, args={})
    Graphsrb::DiEdge.new(id1, id2, args)
  end
end
