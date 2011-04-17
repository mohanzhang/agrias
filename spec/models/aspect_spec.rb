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

  it "can be created underneath a parent" do
    parent = Factory.create(:aspect, :name => "Work and stuff")
    child = Factory.create(:aspect, :name => "Meetings", :parent_clue => "work")

    child.parent.should == parent
  end
end
