require 'spec_helper'

describe User do
  include ActiveRecordHelpers

  it "can have many appointments" do
    assert_has_many(:user, :appointments)
  end

  it "can have many aspects" do
    assert_has_many(:user, :aspects)
  end

  it "can have many buffer items" do
    assert_has_many(:user, :buffer_items)
  end

  it "can have many goals" do
    assert_has_many(:user, :goals)
  end

  it "can have many ideas" do
    assert_has_many(:user, :ideas)
  end

  it "can have many muses" do
    assert_has_many(:user, :muses)
  end

end
