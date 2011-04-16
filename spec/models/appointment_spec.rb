require 'spec_helper'

describe Appointment do
  include ActiveModelHelpers

  it "requires a description" do
    assert_presence(:appointment, :description)
  end

  it "requires a datetime at which it occurs" do
    assert_presence(:appointment, :occurs_at)
  end
end
