require 'faker'

Factory.define :aspect do |x|
  x.name Faker::Lorem.words(1)
end

Factory.define :buffer_item do |x|
  x.phrase Faker::Lorem.words(10)
end

Factory.define :idea do |x|
  x.synopsis Faker::Lorem.sentences(1)
  x.details Faker::Lorem.paragraphs(1)
end
