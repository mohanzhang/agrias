require 'spec_helper'

describe Aspect do
  include ActiveModelHelpers

  it "requires a name" do
    assert_presence(:aspect, :name)
  end

  it "can set a weight" do
    Factory.create(:aspect, :weight => 4).weight.should == 4
  end

  it "has ancestry" do
    parent = Factory.create(:aspect)
    child = Factory.create(:aspect, :parent => parent)

    parent.reload
    parent.children.count.should == 1
  end
end