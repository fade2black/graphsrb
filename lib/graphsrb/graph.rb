class Graphsrb::Graph < Graphsrb::BaseGraph

  #Retrieves adjacent vertices of a vertex
  def adjacent_vertices(vertex)
    nodes = []
    id = vertex.id
    nodes = adj_table[id].nodes unless adj_table[id].nil?
    vertices.each do |vertex|
      next if vertex.id == id
      node = adj_table[vertex.id].find(_create_node(id))
      nodes << _create_node(vertex.id, weight:node.weight) unless node.nil?
    end
    #Convert nodes into vertices
    nodes.map{|node| _create_vertex(node.vertex.id)}
  end

  alias neighborhood adjacent_vertices
  
  #Retrieves incident edges of a vertex
  def incident_edges(id)
    #Convert nodes into edges with weights
    _incident_nodes(id).map{|node| _create_edge(id, node.vertex.id, weight:node.weight)}
  end

  #Returns +degree+ of a vertex
  def degree(id)
    _incident_nodes(id).size
  end

  private
  def _incident_nodes(id)
    nodes = []
    nodes = adj_table[id].nodes unless adj_table[id].nil?
    vertices.each do |vertex|
      next if vertex.id == id
      node = adj_table[vertex.id].find(_create_node(id))
      nodes << _create_node(vertex.id, weight:node.weight) unless node.nil?
    end
    nodes
  end
end
