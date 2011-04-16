require 'faker'

Factory.define :appointment do |x|
  x.description Faker::Lorem.words(5)
  x.occurs_at 5.hours.from_now
end

Factory.define :aspect do |x|
  x.name Faker::Lorem.words(1)
end

Factory.define :buffer_item do |x|
  x.phrase Faker::Lorem.words(10)
end

Factory.define :goal do |x|
  x.statement Faker::Lorem.sentences(1)
  x.accomplish_on 10.days.from_now
end

Factory.define :idea do |x|
  x.synopsis Faker::Lorem.sentences(1)
  x.details Faker::Lorem.paragraphs(1)
end

Factory.define :muse do |x|
  x.name Faker::Lorem.words(2)
end
