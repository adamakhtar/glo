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
      if params.is_a? Glo::Context
        @context = params
      elsif params.is_a? Hash
        @context = Context.new(params)
      else
        raise ArgumentError, "Glo::Op must be initialized with an instance of either Hash or Glo::Context and not #{params.class.to_s}."
      end
    end

    def operations
      OPERATIONS
    end
  end
end