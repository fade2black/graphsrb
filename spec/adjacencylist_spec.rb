require "graphsrb/adjacency_list"

RSpec.describe Graphsrb::AdjacencyList do
  let(:adj_list) {described_class.new}
  let(:node) {described_class.create_node(1, weight: 2.3)}

  it "adds a new node" do
    expect(adj_list.size).to be 0

    expect(adj_list.find(node)).to be nil
    adj_list.add(node)
    expect(adj_list.size).to be 1

    found_node = adj_list.find(node)
    expect(found_node).not_to be nil
    expect(found_node.vertex.id).to be 1
  end

  it "deletes a node" do
    adj_list.add(node)
    expect(adj_list.size).to be 1
    adj_list.delete(node)
    expect(adj_list.size).to be 0
    expect(adj_list.find(node)).to be nil
    adj_list.delete(node)
    expect(adj_list.size).to be 0
  end

  it "clears the list" do
    adj_list.add(node)
    adj_list.add(node)
    expect(adj_list.size).to be 2
    adj_list.clear
    expect(adj_list.size).to be 0
  end

  it "finds nodes" do
    adj_list.add(node)
    adj_list.add(node)
    expect(adj_list.size).to be 2
    expect(adj_list.find(node)).not_to be nil

    node1 = described_class.create_node(1, weight: 0.5)
    expect(adj_list.find(node1)).not_to be nil

    node1 = described_class.create_node(2, weight: 0.5)
    expect(adj_list.find(node1)).to be nil

    adj_list.add(node1)
    expect(adj_list.find(node1)).not_to be nil

    adj_list.clear
    expect(adj_list.find(node)).to be nil
    expect(adj_list.find(node1)).to be nil
  end

  it "returns nodes" do
    adj_list.add(described_class.create_node(1, weight: 2.3))
    adj_list.add(described_class.create_node(2, weight: -2.3))
    adj_list.add(described_class.create_node(3, weight: 0))

    nodes = adj_list.nodes
    expect(nodes.size).to be 3

    expect(nodes[0].vertex.id).to be 1
    expect(nodes[0].weight).to be 2.3

    expect(nodes[1].vertex.id).to be 2
    expect(nodes[1].weight).to be -2.3

    expect(nodes[2].vertex.id).to be 3
    expect(nodes[2].weight).to be 0

  end
end
