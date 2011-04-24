module ActiveRecordHelpers
  def assert_has_many(model, field)
    Factory.create(model).send(field).should_not be_nil
  end
end
