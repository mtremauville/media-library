FactoryBot.define do
  factory :episode do
    title { "MyString" }
    season_number { 1 }
    episode_number { 1 }
    synopsis { "MyText" }
    duration { 1 }
    thumbnail_url { "MyString" }
    media_item { nil }
  end
end
