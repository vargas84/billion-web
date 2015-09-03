FactoryGirl.define do
  factory :transaction do
    amount { Faker::Number.decimal(2) }
    points { Faker::Number.number(5) }
    association :sender, factory: :temp_user
    association :recipient, factory: :project
    competition
  end
end
