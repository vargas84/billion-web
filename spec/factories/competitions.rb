FactoryGirl.define do
  factory :competition do
    code_name { Faker::Lorem.word }
    start_date { Faker::Date.between(10.days.from_now, 20.days.from_now) }
    end_date { Faker::Date.between(25.days.from_now, 30.days.from_now) }

    trait :with_projects do
      after :create do |competition|
        create_list(:project, 1, competition: competition)
      end
    end
  end
end
