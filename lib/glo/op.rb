module Glo
  module Op
    extend ActiveSupport::Concern

    attr_reader :context

    module ClassMethods
      def call(params={})
        op = new(params)
        op.call
        op.context
      end
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
  end
end