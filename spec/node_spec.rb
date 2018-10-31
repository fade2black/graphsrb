require "graphsrb/node"
require "graphsrb/vertex"
require "graphsrb/exceptions"

RSpec.describe Graphsrb::Node do
  it "creates a new node" do
    node = described_class.new(Graphsrb::Vertex.new(1), weight: 2.3)
    expect(node.weight).to be 2.3
  end

  it "creates a new node with default weight value (equal to 1)" do
    node = described_class.new(Graphsrb::Vertex.new(1))
    expect(node.weight).to be 1
  end

  it "comapres two nodes" do
    v1 = Graphsrb::Vertex.new(1)
    v2 = Graphsrb::Vertex.new(1)
    v3 = Graphsrb::Vertex.new(2)

    n1 = described_class.new(v1)
    n2 = described_class.new(v2, weight: 2.2)
    n3 = described_class.new(v3, weight: 2.3)

    expect(v1 == v2).to be true
    expect(v1 == v3).to be false
    expect(v2 == v3).to be false
  end
end
