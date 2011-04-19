module ActiveModelHelpers
  def assert_presence(model, field)
    Factory.build(model, field => nil).should_not be_valid
  end

  def assert_range(model, field, range)
    Factory.build(model, field => range.first - 1).should_not be_valid
    for i in range
      Factory.build(model, field => i).should be_valid
    end
    Factory.build(model, field => range.last + 1).should_not be_valid
  end
end
