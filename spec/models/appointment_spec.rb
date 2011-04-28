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

  it "has a scope for unattended appointments" do
    a1 = Factory.create(:appointment, :attended => false)
    a2 = Factory.create(:appointment, :attended => true)

    Appointment.unattended.size.should == 1
    Appointment.unattended.first.should == a1
  end

  it "has a scope for attended appointments" do
    a1 = Factory.create(:appointment, :attended => false)
    a2 = Factory.create(:appointment, :attended => true)

    Appointment.attended.size.should == 1
    Appointment.attended.first.should == a2
  end

  describe "arg driven" do
    before :each do
      @user = Factory.create(:user)
      @buffer_item = Factory.create(:buffer_item, :user => @user, :phrase => "walk the dog")
    end

    after :each do
      @appt.try(:save!)
    end

    it "can be assigned using a date and time" do
      @appt = Appointment.process!(:user_id => @user.id, :args => "mk appt 1 4/12/11 at 5 pm")
      @appt.occurs_at.should == Time.new(2011,04,12,17,0)
    end

    it "can be assigned using days from now" do
      class << Time
        def now
          Time.new(2011,4,18)
        end
      end

      @appt = Appointment.process!(:user_id => @user.id, :args => "make appt 1 4 days from now at 10 am")
      @appt.occurs_at.should == Time.new(2011,4,22,10)
      #TODO this fails at the end of the month
    end

  end
end
