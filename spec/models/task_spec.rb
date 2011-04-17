require 'spec_helper'

describe Task do
  include ActiveModelHelpers

  it "must belong to an aspect" do
    assert_presence(:task, :aspect)
  end

  it "requires a description" do
    assert_presence(:task, :description)
  end

  it "requires a due on date" do
    assert_presence(:task, :due_on)
  end

  it "can be created underneath a parent" do
    aspect = Factory.create(:aspect, :name => "Work and stuff")
    task = Factory.create(:task, :parent_clue => "work")

    task.aspect.should == aspect
  end
end
