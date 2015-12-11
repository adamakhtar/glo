module Glo
  class Pipe
    attr_reader :operations

    def initialize(operations)
      @operations = operations
    end

    def call(context={})
      operations.each do |operation|
        context = operation.call(context)
      end
      context
    end
  end
end