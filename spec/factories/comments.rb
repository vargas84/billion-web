FactoryGirl.define do
  factory :comment do
    author { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
    project
  end
end
