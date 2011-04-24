require 'spec_helper'

describe Muse do
  include ActiveModelHelpers

  it "must belong to a user" do
    assert_presence(:muse, :user)
  end

  it "requires a name" do
    assert_presence(:muse, :name)
  end
end
