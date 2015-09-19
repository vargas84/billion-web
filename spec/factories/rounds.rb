FactoryGirl.define do
  factory :round, aliases: [:active_round] do
    association :competition, factory: :current_competition
    started_at { 1.day.ago }
    ended_at { 1.day.from_now }

    factory :inactive_round do
      started_at { 2.days.ago }
      ended_at { 1.day.ago }
    end
  end
end
