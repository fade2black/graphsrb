require "graphsrb/edge"

RSpec.describe Graphsrb::Edge do
  it "compares two edges" do
    expect(described_class.new(1,2) == described_class.new(2,1)).to be true
  end

  it "computes difference" do
    edges1 = [described_class.new(1,2)]
    edges2 = [described_class.new(2,1)]

    expect((edges1 - edges2).empty?).to be true
  end
end
