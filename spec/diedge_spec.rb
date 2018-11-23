require "graphsrb/diedge"

RSpec.describe Graphsrb::DiEdge do
  it "compares two edges" do
    expect(described_class.new(1,2) == described_class.new(1,2)).to be true
  end

  it "computes difference" do
    edges1 = [described_class.new(1,2)]
    edges2 = [described_class.new(1,2)]

    expect((edges1 - edges2).empty?).to be true

    edges1 = [described_class.new(2,1)]
    edges2 = [described_class.new(1,2)]

    expect((edges1 - edges2).size).to eq(1)
  end
end
