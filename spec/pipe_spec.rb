require 'spec_helper'

describe Glo::Pipe do

  dummy_op = Class.new do
    include Glo::Op

    def call
      true
    end
  end

  describe ".initialize" do
    it "accepts an array of ops" do
      pipeline = Glo::Pipe.new([dummy_op])
        
      expect(pipeline.operations).to eq [dummy_op]
    end
  end

  describe ".call" do
    it "runs each operation" do
      context = {}
    
      pipeline = Glo::Pipe.new([dummy_op])

      expect(dummy_op).to receive(:call)
      pipeline.call(context)  
    end
  end
end
