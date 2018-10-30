require "graphsrb/vertex"
require "graphsrb/exceptions"

RSpec.describe Graphsrb::Vertex do
  let(:vertex){Graphsrb::Vertex.new(display_name: 'foo', id: 1)}

  it "raises exception" do
    expect{described_class.new}.to raise_error Graphsrb::VertexInitializationError
  end

  it "has neighbours" do
    expect(vertex.neighbours).not_to be nil
  end

  it "has display name" do
    expect(vertex.display_name).to eql 'foo'
  end

  it "has id" do
    expect(vertex.id).to be 1
  end

  it "compares two vertices" do
    v1 = described_class.new(id: 2)
    v2 = described_class.new(id: 3)
    v3 = described_class.new(id: 3)

    expect(v1==v2).to be false
    expect(v2==v3).to be true
  end

  it "adds a neighbour" do
    expect(vertex.degree).to be 0
    vertex.add_neighbour(described_class.new(display_name: 'bar', id: 2))
    expect(vertex.degree).to be 1
  end

  it "removes a neighbour" do
    expect(vertex.degree).to be 0
    vertex.add_neighbour(Graphsrb::Vertex.new(display_name: 'bar', id: 2))
    expect(vertex.degree).to be 1
    vertex.remove_neighbour(2)
    expect(vertex.degree).to be 0
  end

end
