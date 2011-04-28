class EmptyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value && value.size > 0
      value.each do |elem|
        record.errors[attribute] << elem
      end
    end
  end
end 

