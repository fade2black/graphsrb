module Graphsrb
  class VertexInitializationError < StandardError
    def initialize(msg="Wrong vertex initialization")
      super
    end
  end
end
