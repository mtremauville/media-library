FactoryBot.define do
  factory :media_item do
    title { "MyString" }
    media_type { "MyString" }
    external_id { "MyString" }
    poster_url { "MyString" }
    synopsis { "MyText" }
    rating { "9.99" }
    release_date { "2026-06-10" }
    user { nil }
    metadata { "" }
  end
end
