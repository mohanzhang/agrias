require 'spec_helper'

describe BufferItem do
  include ActiveModelHelpers

  it "requires a phrase" do
    assert_presence(:buffer_item, :phrase)
  end

  it "requires a unique phrase" do
    Factory.create(:buffer_item, :phrase => "asdf")
    Factory.build(:buffer_item, :phrase => "asdf").should_not be_valid
  end

  it "has default scope of listing by created_at ASC" do
    b1 = Factory.create(:buffer_item, :created_at => 2.days.ago)
    b2 = Factory.create(:buffer_item, :created_at => 3.days.ago)
    b3 = Factory.create(:buffer_item, :created_at => Time.now)

    bs = BufferItem.all
    bs[0].should == b2
    bs[1].should == b1
    bs[2].should == b3
  end

  describe "create using args" do
    it "can be created with a phrase" do
      buffer_item = Factory.create(:buffer_item, :args => "anything at all")
      buffer_item.phrase.should == "anything at all"
    end
  end
end
