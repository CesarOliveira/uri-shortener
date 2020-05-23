FactoryBot.define do
  factory :link   do
    title { Faker::TvShows::GameOfThrones.house }
    destination_url { Faker::Internet.url }
    identifier { Faker::Lorem.characters(number: 20) }
  end
end
