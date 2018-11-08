require "graphsrb/node"

RSpec.describe Graphsrb::Node do
  it "creates a new node" do
    node = described_class.new(1, weight: 2.3, depth:4)
    expect(node.weight).to be 2.3
  end

  it "comapres two nodes" do
    vertex_id1 = 1
    vertex_id2 = 1
    vertex_id3 = 2

    n1 = described_class.new(vertex_id1)
    n2 = described_class.new(vertex_id2, weight: 2.2)
    n3 = described_class.new(vertex_id3, weight: 2.3)

    expect(n1 == n2).to be true
    expect(n1 == n3).to be false
    expect(n2 == n3).to be false
  end
end
