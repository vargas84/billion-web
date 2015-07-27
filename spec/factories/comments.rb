FactoryGirl.define do
  factory :comment do
    author 'test'
    content 'Comment about the project'
    project
  end
end
