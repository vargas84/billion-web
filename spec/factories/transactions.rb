FactoryGirl.define do
  factory :transaction do
    amount { Faker::Number.decimal(2) }
    association :sender, factory: :TempUser
    association :recipient, factory: :project
  end
end
