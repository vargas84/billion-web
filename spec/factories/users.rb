FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }

    factory :admin do
      role_id 2
    end
  end
end
