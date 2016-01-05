require 'spec_helper'

describe Glo::Chain do
  chain_klass_a = Class.new do
    include Glo::Chain

    OPERATIONS = [:step_a, :step_b]

    def step_a
      context.name = 'peter'
    end

    def step_b
      context.age = 30
    end
  end

  chain_klass_b = Class.new do
    include Glo::Chain

    OPERATIONS = [:step_a, :step_b]

    def step_a
      context.name = "rodger"
      context.fail!
    end

    def step_b
      context.age = 30
    end
  end

  describe ".initialize" do
    it "accepts no arguments" do
      chain = chain_klass_a.new
      expect(chain).to respond_to :call
    end

    it "accepts a hash" do
      chain = chain_klass_a.new(name: 'barry')

      expect(chain.context).to be_a Glo::Context
      expect(chain.context.name).to eq 'barry'
    end

    it "accepts a context" do
      context = Glo::Context.new(name: 'barry')
      chain = chain_klass_a.new(context)

      expect(chain.context.name).to eq context.name
    end
  end

  describe "#operations" do
    it "returns the method names of operations set to be run" do
      chain = chain_klass_a.new

      expect(chain.operations).to eq [:step_a, :step_b]
    end
  end

  describe ".call" do
    it "runs each operation" do
      context = {}

      chain = chain_klass_a.new(context)

      expect(chain).to receive(:step_a)
      expect(chain).to receive(:step_b)
      chain.call
    end

    it "halts the chain if an operation fails" do
      context = {}

      chain = chain_klass_b.new(context)
      expect(chain).to_not receive(:step_b)
      chain.call
    end

    it "lets each chain change the context" do
      context = {name: 'ross'}
      chain = chain_klass_a.new(context)

      context = chain.call

      expect(context.name).to eq 'peter'
    end
  end
end
