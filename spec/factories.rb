require 'faker'

Factory.define :appointment do |x|
  x.association :user
  x.description Faker::Lorem.words(5)
  x.occurs_at 5.hours.from_now
end

Factory.define :aspect do |x|
  x.association :user
  x.name Faker::Lorem.words(1)
  x.weight 2
end

Factory.define :buffer_item do |x|
  x.association :user
  x.phrase Faker::Lorem.words(10)
end

Factory.define :goal do |x|
  x.association :user
  x.statement Faker::Lorem.sentences(1)
  x.accomplish_on 10.days.from_now
end

Factory.define :idea do |x|
  x.association :user
  x.synopsis Faker::Lorem.sentences(1)
  x.details Faker::Lorem.paragraphs(1)
end

Factory.define :muse do |x|
  x.association :user
  x.name Faker::Lorem.words(2)
end

Factory.define :task do |x|
  x.association :aspect
  x.description Faker::Lorem.words(5)
  x.due_on 10.days.from_now.to_date
  x.importance 2
  x.accomplished false
end

Factory.define :subtask do |x|
  x.association :task
  x.description Faker::Lorem.words(5)
end

Factory.define :user do |x|
  x.sequence(:email) {|n| n.to_s + Faker::Internet.email}
  x.password "asdfasdf"
  x.password_confirmation "asdfasdf"
end
