require 'faker'

Factory.define :buffer_item do |b|
  b.phrase Faker::Lorem.words(10)
end
