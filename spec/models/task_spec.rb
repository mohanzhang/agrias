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

  describe "create using args" do
    before :each do
      @buffer_item = Factory.create(:buffer_item, :phrase => "walk the dog")
      @aspect = Factory.create(:aspect, :name => "Work and stuff")
    end

    it "can be created underneath a parent" do
      task = Factory.create(:task, :args => "task 1 under work due in 2 days")
      task.aspect.should == @aspect
    end

    it "can be assigned a due date using days" do
      task = Factory.create(:task, :args => "task 1 under work due in 2 days")
      task.due_on.should == 2.days.from_now.to_date
    end

    it "can be assigned a due date using a date" do
      task = Factory.create(:task, :args => "task 1 under work due on 4/12")
      task.due_on.should == Date.new(2011,4,12)
      #TODO this breaks when the month is in the new year
    end
  end
end
