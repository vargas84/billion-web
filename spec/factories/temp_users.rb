FactoryGirl.define do
  factory :temp_user do
    sequence(:email) { |n| Faker::Internet.email("test#{n}") }

    trait :in_person do
      in_person true
    end

    trait :on_web do
      in_person false
    end
  end
end
