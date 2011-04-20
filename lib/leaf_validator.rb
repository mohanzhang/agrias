class LeafValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be a leaf' if value && value.has_children?
  end
end
