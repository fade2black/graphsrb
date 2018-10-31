require "graphsrb/vertex"
require "graphsrb/exceptions"

RSpec.describe Graphsrb::Vertex do
  it "raises exception" do
    expect{described_class.new(nil)}.to raise_error Graphsrb::VertexInitializationError
  end

  it "creates a vertex" do
    v1 = described_class.new(1)
    expect(v1.id).to be 1
  end

  it "comapres two vertices" do
    v1 = described_class.new(1)
    v2 = described_class.new(1)
    v3 = described_class.new(2)
    expect(v1 == v2).to be true
    expect(v1 == v3).to be false
    expect(v2 == v3).to be false
  end
end
