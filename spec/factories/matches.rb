FactoryGirl.define do
  factory :match do
    association :round, factory: :active_round
    association :project_1, factory: :project
    association :project_2, factory: :project
  end
end
