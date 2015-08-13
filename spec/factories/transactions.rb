FactoryGirl.define do
  factory :transaction do
    amount Faker::Number.number(3)
    association :sender, factory: :user
    association :recipient, factory: :project
  end
end
