require 'spec_helper'

describe Goal do
  include ActiveModelHelpers

  it "requires a statement" do
    assert_presence(:goal, :statement)
  end

  it "requires an accomplished date" do
    assert_presence(:goal, :accomplish_on)
  end
end
