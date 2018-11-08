
class Graphsrb::AdjacencyList
  def initialize
    @adj_list = []
  end

  #Adds a node to the adjacency list
  def add(node)
    adj_list << node.clone
  end

  #Adds a node to the adjacency list
  def <<(node)
    add(node)
  end

  #Returns the number of nodes in the adjacency list
  def size
    adj_list.size
  end

  #Removes a node from the adjacency list
  def delete(node)
    adj_list.delete(node)
  end

  #Searches for a node in the adjacency list
  #Returns nil if not found
  def find(node)
    index = adj_list.index node
    if index.nil?
      return nil
    else
      adj_list[index]
    end
  end

  #Returns all nodes
  def nodes
    adj_list.clone
  end

  #Returns true if the adjacency list contains the node, false otherwise
  def has_node?(node)
    not find(node).nil?
  end

  #Remove all nodes from the list
  def clear
    adj_list.clear
  end

  #Creates and returns the newly created node
  def self.create_node(vertex_id, args={})
    Graphsrb::Node.new(vertex_id, args)
  end

  private
  attr_reader :adj_list
end
