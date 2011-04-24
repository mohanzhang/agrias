require 'spec_helper'

describe Aspect do
  include ActiveModelHelpers
  include ActiveRecordHelpers

  it "must belong to a user" do
    assert_presence(:aspect, :user)
  end

  it "requires a name" do
    assert_presence(:aspect, :name)
  end

  it "requires a unique name" do
    Factory.create(:aspect, :name => "asdf")
    Factory.build(:aspect, :name => "asdf").should_not be_valid
  end

  it "requires a weight between 1 and 3 inclusive" do
    assert_presence(:aspect, :weight)
    assert_range(:aspect, :weight, 1..3)
  end

  it "has ancestry" do
    parent = Factory.create(:aspect)
    child = Factory.create(:aspect, :parent => parent)

    parent.reload
    parent.children.count.should == 1
  end

  it "can find aspects by clue" do
    a = Factory.create(:aspect, :name => "Test and stuff")
    Aspect.with_clue("test").first.should == a
  end

  describe "tasks" do
    it "can have many tasks" do
      assert_has_many(:aspect, :tasks)
    end

    it "returns the regular set of tasks in importance DESC if the aspect is a leaf" do
      aspect = Factory.create(:aspect)
      t1 = Factory.create(:task, :aspect => aspect, :importance => 1)
      t2 = Factory.create(:task, :aspect => aspect, :importance => 3)

      aspect.tasks.first.should == t2
      aspect.tasks.last.should == t1
    end

    it "represents all the tasks of all its descendants if the aspect is not a leaf" do
      a1 = Factory.create(:aspect, :weight => 2)
      a1t1 = Factory.create(:task, :aspect => a1, :importance => 1)
      a1t2 = Factory.create(:task, :aspect => a1, :importance => 3)
      a11 = Factory.create(:aspect, :parent => a1, :weight => 1)
      a11t1 = Factory.create(:task, :aspect => a11, :importance => 2)
      a12 = Factory.create(:aspect, :parent => a1, :weight => 3)
      a12t1 = Factory.create(:task, :aspect => a12, :importance => 2)

      ts = a1.tasks
      ts.size.should == 4
      ts[0].id.should == a1t2.id
      ts[1].id.should == a1t1.id
      ts[2].id.should == a12t1.id
      ts[3].id.should == a11t1.id
    end
  end

  describe "create using args" do
    before :each do
      @aspect = Factory.create(:aspect, :name => "Work and stuff")
    end

    it "can be created underneath a parent" do
      aspect = Factory.create(:aspect, :args => "aspect test 3 under work")
      aspect.parent.should == @aspect
      
      Factory.build(:aspect, :args => "aspect test under work 3").should_not be_valid
    end

    it "can be created as a root" do
      aspect = Factory.create(:aspect, :args => "aspect Hello 2 as root")
      aspect.name.should == "Hello"
    end

    it "should be created with a weight" do
      aspect = Factory.create(:aspect, :args => "aspect Hello 3 as root")
      aspect.weight.should == 3
    end
  end
end
