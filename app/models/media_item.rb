class MediaItem < ApplicationRecord
  belongs_to :user
  has_many :episodes, dependent: :destroy
  has_many :tracks, dependent: :destroy

  validates :title,      presence: true
  validates :media_type, inclusion: { in: %w[movie series album] }
  validates :external_id, uniqueness: { scope: [:user_id, :media_type] }

  scope :movies,  -> { where(media_type: "movie") }
  scope :series,  -> { where(media_type: "series") }
  scope :albums,  -> { where(media_type: "album") }

  # Algolia Search
  include AlgoliaSearch

  algoliasearch do
    attribute :title, :media_type, :synopsis, :rating, :release_date
    attribute :poster_url
    searchableAttributes ["title", "synopsis"]
    customRanking ["desc(rating)"]
  end
end
