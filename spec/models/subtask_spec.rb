require 'spec_helper'

describe Subtask do
  include ActiveModelHelpers

  it "must belong to a task" do
    assert_presence(:subtask, :task)
  end

  it "must have a description" do
    assert_presence(:subtask, :description)
  end
end
