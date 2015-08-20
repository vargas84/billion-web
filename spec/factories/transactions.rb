FactoryGirl.define do
  factory :transaction do
    amount { Faker::Number.decimal(2) }
    association :sender, factory: :temp_user
    association :recipient, factory: :project
  end
end
