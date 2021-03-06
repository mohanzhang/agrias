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

  it "requires an importance between 1 and 3 inclusive" do
    assert_presence(:task, :importance)
    assert_range(:task, :importance, 1..3)
  end

  it "cannot be created under an aspect that has children aspects" do
    parent = Factory.create(:aspect)
    child = Factory.create(:aspect, :parent => parent)
    Factory.build(:task, :aspect => parent).should_not be_valid
    Factory.build(:task, :aspect => child).should be_valid
  end

  it "can provide a list of weights" do
    a1 = Factory.create(:aspect, :weight => 3)
    a11 = Factory.create(:aspect, :parent => a1, :weight => 2)
    a111 = Factory.create(:aspect, :parent => a11, :weight => 3)
    a12 = Factory.create(:aspect, :parent => a1, :weight => 1)

    a111t1 = Factory.create(:task, :aspect => a111)
    a12t1 = Factory.create(:task, :aspect => a12)

    a111t1.weight.should == [3,2,3]
    a12t1.weight.should == [3,1]
  end

  describe "task state" do
    it "must have a state" do
      assert_presence(:task, :state)
    end

    it "can be not started" do
      t = Factory.create(:task, :state => Task::NOT_STARTED)
      t.state.should == Task::NOT_STARTED
      t.not_started?.should be_true
    end

    it "can be in progress" do
      t = Factory.create(:task, :state => Task::IN_PROGRESS)
      t.state.should == Task::IN_PROGRESS
      t.in_progress?.should be_true
    end

    it "can be waiting for resolution" do
      t = Factory.create(:task, :state => Task::WAITING)
      t.state.should == Task::WAITING
      t.waiting?.should be_true
    end

    it "can be accomplished" do
      t = Factory.create(:task, :state => Task::ACCOMPLISHED)
      t.state.should == Task::ACCOMPLISHED
      t.accomplished?.should be_true
    end

    it "must be a known state" do
      assert_range(:task, :state, 1..4)
    end
  end

  describe "arg driven" do
    before :each do
      @user = Factory.create(:user)
      @buffer_item = Factory.create(:buffer_item, :user => @user, :phrase => "walk the dog")
      @aspect = Factory.create(:aspect, :user => @user, :name => "Work and stuff")
    end

    after :each do
      if @task
        @task.save!
      end
    end

    it "can be created underneath a parent" do
      @task = Task.process!(:args => "mk task 1 under work due in 2 days i1", :user_id => @user.id)
      @task.aspect.should == @aspect
    end

    it "can be assigned a due date using days" do
      @task = Task.process!(:args => "make task 1 under work due in 2 days i2", :user_id => @user.id)
      @task.due_on.should == 2.days.from_now.to_date
    end

    it "can be assigned a due date using a date" do
      @task = Task.process!(:args => "make task 1 under work due Apr 12, 2011 i3", :user_id => @user.id)
      @task.due_on.should == Date.new(2011,4,12)
      #TODO this breaks when the month is in the new year
    end

    it "can assign the importance" do
      @task = Task.process!(:args => "mk task 1 under work due 4/12/11 i3", :user_id => @user.id)
      @task.importance.should == 3
    end

    it "can't be created under another user's aspect" do
      u2 = Factory.create(:user)

      a1 = Factory.create(:aspect, :user => @user, :name => "Blah blah")
      a2 = Factory.create(:aspect, :user => u2, :name => "Test")

      task = Task.process!(:args => "make task 1 under test due 4/12/11 i3", :user_id => @user.id).should_not be_valid
    end
  end
end
