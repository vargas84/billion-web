FactoryGirl.define do
  factory :transaction do
    amount Faker::Number.number(3)
    user
    project
  end
end
