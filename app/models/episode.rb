class Episode < ApplicationRecord
  belongs_to :media_item
  validates :title, :season_number, :episode_number, presence: true
  default_scope { order(season_number: :asc, episode_number: :asc) }
end

# app/models/track.rb
class Track < ApplicationRecord
  belongs_to :media_item
  validates :title, :track_number, presence: true
  default_scope { order(track_number: :asc) }
end
