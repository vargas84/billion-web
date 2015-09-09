FactoryGirl.define do
  factory :competition, aliases: [:current_competition] do
    code_name { Faker::Lorem.word }
    start_date { Faker::Date.backward(5) }
    end_date { Faker::Date.forward(5) }

    trait :with_projects do
      after(:build, :stub) do |competition|
        create_list(:project, 1, competition: competition)
      end
    end

    factory :previous_competition do
      start_date { Faker::Date.backward(100) }
      end_date { Faker::Date.backward(50) }
    end

    factory :future_competition do
      start_date { Faker::Date.forward(50) }
      end_date { Faker::Date.forward(100) }
    end
  end
end
