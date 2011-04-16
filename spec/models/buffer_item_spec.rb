require 'spec_helper'

describe BufferItem do
  include ActiveModelHelpers

  it "requires a phrase" do
    assert_presence(:buffer_item, :phrase)
  end
end
