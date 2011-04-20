require 'spec_helper'

describe Appointment do
  include ActiveModelHelpers

  it "must belong to a user" do
    assert_presence(:appointment, :user)
  end

  it "requires a description" do
    assert_presence(:appointment, :description)
  end

  it "requires a datetime at which it occurs" do
    assert_presence(:appointment, :occurs_at)
  end
  
  it "has default scope of listing by occurs_at ASC" do
    a1 = Factory.create(:appointment, :occurs_at => 2.days.ago)
    a2 = Factory.create(:appointment, :occurs_at => 3.days.ago)
    a3 = Factory.create(:appointment, :occurs_at => Time.now)

    as = Appointment.all
    as[0].should == a2
    as[1].should == a1
    as[2].should == a3
  end

  describe "create using args" do
    before :each do
      @buffer_item = Factory.create(:buffer_item, :phrase => "walk the dog")
    end

    it "can be assigned using a date and time" do
      appt = Factory.create(:appointment, :args => "appt 1 4/12/11 at 5 pm")
      appt.occurs_at.should == Time.new(2011,04,12,17,0)
    end

    it "can be assigned using days from now" do
      appt = Factory.create(:appointment, :args => "appt 1 4 days from now at 10 am")
      now = Time.now
      appt.occurs_at.should == Time.new(now.year,now.month,now.day+4,10,0)
    end

  end
end
