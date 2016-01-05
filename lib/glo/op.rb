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
      @context = Glo::Context.build(params)
    end
  end
end