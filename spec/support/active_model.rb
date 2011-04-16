module ActiveModelHelpers
  def assert_presence(model, field)
    Factory.build(model, field => nil).should_not be_valid
  end
end
