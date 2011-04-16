require 'faker'

Factory.define :aspect do |a|
  a.name Faker::Lorem.words(1)
end

Factory.define :buffer_item do |b|
  b.phrase Faker::Lorem.words(10)
end
