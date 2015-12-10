module Glo
  class Pipe
    attr_reader :operations

    def initialize(operations)
      @operations = operations
    end
  end
end