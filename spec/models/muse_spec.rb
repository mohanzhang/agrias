require 'spec_helper'

describe Muse do
  include ActiveModelHelpers

  it "requires a name" do
    assert_presence(:muse, :name)
  end
end
