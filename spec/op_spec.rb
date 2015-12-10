require 'spec_helper'

describe Glo::Op do

  class Dummy 
    include Glo::Op
  end

  describe ".initialize" do
    it "accepts no arguments" do
      op = Dummy.new

      expect(op.context).to be_a Glo::Context
    end

    it "accepts a hash" do
      op = Dummy.new(name: 'barry')

      expect(op.context).to be_a Glo::Context
      expect(op.context.name).to eq 'barry'
    end

    it "accepts a context" do
      context = Glo::Context.new(name: 'barry')
      op = Dummy.new(context)

      expect(op.context.name).to eq context.name
    end
  end
end
