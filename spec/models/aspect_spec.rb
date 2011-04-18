require 'spec_helper'

describe Aspect do
  include ActiveModelHelpers

  it "requires a name" do
    assert_presence(:aspect, :name)
  end

  it "requires a unique name" do
    Factory.create(:aspect, :name => "asdf")
    Factory.build(:aspect, :name => "asdf").should_not be_valid
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

  describe "create using args" do
    before :each do
      @aspect = Factory.create(:aspect, :name => "Work and stuff")
    end

    it "can be created underneath a parent" do
      aspect = Factory.create(:aspect, :args => "aspect test under work")
      aspect.parent.should == @aspect
    end

    it "can be created as a root" do
      aspect = Factory.create(:aspect, :args => "aspect Hello")
      aspect.name.should == "Hello"
    end
  end
end
