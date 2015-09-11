FactoryGirl.define do
  factory :project do
    name { Faker::Company.name }
    blurb { Faker::Lorem.paragraph }
    description do
      rand(3..4).times.map do
        [
          "# #{Faker::Lorem.sentence}",
          "#{Faker::Lorem.paragraph(5)}",
          "#{Faker::Lorem.paragraph(10)}",
          "#{Faker::Lorem.sentences(5).map { |s| "- #{s}" }.join("\n") }",
          "#{Faker::Lorem.paragraph(10)}",
          "#{Faker::Lorem.sentences(5).map.with_index { |s, i| "#{i + 1}. #{s}" }.join("\n") }"
        ].join("\n\n")
      end.join("\n\n")
    end
    card_image_url 'http://lorempixel.com/400/200/business'
    video_url 'https://www.youtube.com/watch?v=SYOQ4w9EXzI'
    competition

    trait :with_comments do
      after(:build, :stub) do |project|
        create_list(:comment, 2, project: project)
      end
    end

    trait :with_collaborators do
      after(:build, :stub) do |project|
        create_list(:membership, 3, project: project)
      end
    end

    trait :with_competitor do
      association :competitor, factory: :project
    end
  end
end
