require 'spec_helper'

describe Glo::Context do
  describe "initialize" do
    it "sets given params" do
      context = Glo::Context.new(email: 'adam@example.com', name: 'adam')

      expect(context.email).to eq 'adam@example.com'
      expect(context.name).to eq 'adam'
    end
  end

  describe "setting and reading values via method setter" do
    it "works" do
      context = Glo::Context.new

      context.name = "adam"

      expect(context.name).to eq "adam"
    end
  end

  it "is success by default" do
    context = Glo::Context.new

    expect(context.success?).to be_truthy
    expect(context.fail?).to be_falsey
  end

  describe "#success!" do
    it "sets as success" do
      context = Glo::Context.new

      context.success!

      expect(context.success?).to be_truthy
    end
  end
end
