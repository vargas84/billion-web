FactoryGirl.define do
  factory :transaction do
    amount Faker::Number.decimal(2)
    association :sender, factory: :user
    association :recipient, factory: :project
  end
end
