require 'spec_helper'

describe Idea do
  include ActiveModelHelpers

  it "requires a synopsis" do
    assert_presence(:idea, :synopsis)
  end
end
