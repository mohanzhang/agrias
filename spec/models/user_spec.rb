require 'spec_helper'

describe User do
  include ActiveRecordHelpers

  it "can have many appointments" do
    assert_has_many(:user, :appointments)
  end

  it "can have many aspects in weight DESC order" do
    assert_has_many(:user, :aspects)

    user = Factory.create(:user)

    a1 = Factory.create(:aspect, :user => user, :weight => 2)
    a2 = Factory.create(:aspect, :user => user, :weight => 3)
    a3 = Factory.create(:aspect, :user => user, :weight => 1)

    as = user.aspects.all
    as[0].should == a2
    as[1].should == a1
    as[2].should == a3
  end

  it "can have many buffer items" do
    assert_has_many(:user, :buffer_items)
  end

  it "can have many goals" do
    assert_has_many(:user, :goals)
  end

  it "can have many ideas" do
    assert_has_many(:user, :ideas)
  end

  it "can have many muses" do
    assert_has_many(:user, :muses)
  end

  describe "tasks" do
    it "can have many tasks returned in priority order" do
      user = Factory.create(:user)
      a1 = Factory.create(:aspect, :user => user, :weight => 3)
      a11 = Factory.create(:aspect, :user => user, :parent => a1, :weight => 3)
      a111 = Factory.create(:aspect, :user => user, :parent => a11, :weight => 1)
      a112 = Factory.create(:aspect, :user => user, :parent => a11, :weight => 3)
      a12 = Factory.create(:aspect, :user => user, :parent => a1, :weight => 2)
      a2 = Factory.create(:aspect, :user => user, :weight => 2)

      a111t1 = Factory.create(:task, :aspect => a111, :importance => 3)
      a112t1 = Factory.create(:task, :aspect => a112, :importance => 2)
      a12t1 = Factory.create(:task, :aspect => a12, :importance => 2)
      a12t2 = Factory.create(:task, :aspect => a12, :importance => 3)
      a2t1 = Factory.create(:task, :aspect => a2, :importance => 2)
      a2t2 = Factory.create(:task, :aspect => a2, :importance => 1)

      # Tasks look like this:
      #                A1 (3)                         A2 (2)
      #             /      \                          |- a2t1 (2)
      #         A11 (3)     A12 (2)                   |- a2t2 (1)
      #          / \         |- a12t1 (2)
      #   A111 (1)  A112 (3) |- a12t2 (3)
      #  a111t1 (3) a112t1 (2)

      ts = user.tasks(:limit => 5)
      ts[0].should == a112t1
      ts[1].should == a111t1
      ts[2].should == a12t2
      ts[3].should == a12t1
      ts[4].should == a2t1
    end

    it "can filter by task state" do
      user = Factory.create(:user)
      a1 = Factory.create(:aspect, :user => user, :weight => 3)
      a1t1 = Factory.create(:task, :aspect => a1, :state => Task::NOT_STARTED)
      a1t2 = Factory.create(:task, :aspect => a1, :state => Task::NOT_STARTED)
      a1t3 = Factory.create(:task, :aspect => a1, :state => Task::ACCOMPLISHED)

      user.tasks(:state => Task::NOT_STARTED).size.should == 2
      user.tasks(:state => Task::ACCOMPLISHED).size.should == 1
      user.tasks().size.should == 3
    end
  end
end
