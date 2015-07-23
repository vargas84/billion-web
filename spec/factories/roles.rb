FactoryGirl.define do
  factory :role, aliases: [:user_role] do
    initialize_with { Role.find_or_initialize_by attributes }

    id 1
    name 'user'

    factory :admin_role do
      initialize_with { Role.find_or_initialize_by attributes }

      id 2
      name 'admin'
    end
  end
end
