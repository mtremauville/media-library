module Tmdb
  class SeriesService < BaseService
    def search(query)
      data = get("/search/tv", query: query)
      return [] unless data
      data["results"].map { |s| format_series(s) }
    end

    def find(tmdb_id)
      data = get("/tv/#{tmdb_id}", append_to_response: "credits,videos")
      return nil unless data
      format_series(data, detailed: true)
    end

    def episodes(tmdb_id, season_number)
      data = get("/tv/#{tmdb_id}/season/#{season_number}")
      return [] unless data

      data["episodes"].map do |ep|
        {
          title:          ep["name"],
          season_number:  ep["season_number"],
          episode_number: ep["episode_number"],
          synopsis:       ep["overview"],
          duration:       ep["runtime"],
          thumbnail_url:  ep["still_path"] ? "#{IMAGE_BASE}#{ep['still_path']}" : nil,
          air_date:       ep["air_date"]
        }
      end
    end

    private

    def format_series(data, detailed: false)
      result = {
        external_id:  data["id"].to_s,
        title:        data["name"],
        synopsis:     data["overview"],
        poster_url:   data["poster_path"] ? "#{IMAGE_BASE}#{data['poster_path']}" : nil,
        rating:       data["vote_average"],
        release_date: data["first_air_date"],
        media_type:   "series",
        seasons_count: data["number_of_seasons"]
      }

      if detailed
        result[:genres]  = data.dig("genres")&.map { |g| g["name"] }
        result[:seasons] = data["seasons"]&.map { |s|
          { number: s["season_number"], episodes: s["episode_count"], poster: "#{IMAGE_BASE}#{s['poster_path']}" }
        }
      end
      result
    end
  end
end
