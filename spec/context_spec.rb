require 'spec_helper'

describe Glo::Context do
  describe "initialize" do
    it "sets given params" do
      context = Glo::Context.new(email: 'adam@example.com', name: 'adam')

      expect(context.email).to eq 'adam@example.com'
      expect(context.name).to eq 'adam'
    end
  end
end
