FactoryGirl.define do
  factory :temp_user do
    sequence(:email) { |n| Faker::Internet.email("test#{n}") }
  end
end
