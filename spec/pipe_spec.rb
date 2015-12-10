require 'spec_helper'

describe Glo::Pipe do

  class Dummy
    include Glo::Op
  end

  describe ".initialize" do
    it "accepts an array of ops" do
      pipeline = Glo::Pipe.new([Dummy])
        
      expect(pipeline.operations).to eq [Dummy]
    end
  end
end
