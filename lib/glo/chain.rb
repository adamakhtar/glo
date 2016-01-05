module Glo
  module Chain
    extend ActiveSupport::Concern

    attr_reader :context,
                :operations

    module ClassMethods
      def call(params={})
        chain = new(params)
        chain.call
      end
    end

    def call
      operations.each do |operation|
        break if context.fail?
        send(operation)
      end
      context
    end

    def initialize(params={})
      @context = Glo::Context.build(params)
    end

    def operations
      OPERATIONS
    end
  end
end