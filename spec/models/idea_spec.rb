require 'spec_helper'

describe Idea do
  include ActiveModelHelpers

  it "must belong to a user" do
    assert_presence(:idea, :user)
  end

  it "requires a synopsis" do
    assert_presence(:idea, :synopsis)
  end
end
