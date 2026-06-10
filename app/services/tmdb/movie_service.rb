module Tmdb
  class MovieService < BaseService
    def search(query)
      data = get("/search/movie", query: query)
      return [] unless data

      data["results"].map { |m| format_movie(m) }
    end

    def find(tmdb_id)
      data = get("/movie/#{tmdb_id}", append_to_response: "credits,videos")
      return nil unless data
      format_movie(data, detailed: true)
    end

    private

    def format_movie(data, detailed: false)
      result = {
        external_id:  data["id"].to_s,
        title:        data["title"],
        synopsis:     data["overview"],
        poster_url:   data["poster_path"] ? "#{IMAGE_BASE}#{data['poster_path']}" : nil,
        rating:       data["vote_average"],
        release_date: data["release_date"],
        media_type:   "movie"
      }

      if detailed
        result[:genres]   = data.dig("genres")&.map { |g| g["name"] }
        result[:runtime]  = data["runtime"]
        result[:trailer]  = extract_trailer(data.dig("videos", "results"))
        result[:cast]     = data.dig("credits", "cast")&.first(5)&.map { |c|
          { name: c["name"], character: c["character"], photo: "#{IMAGE_BASE}#{c['profile_path']}" }
        }
      end
      result
    end

    def extract_trailer(videos)
      return nil unless videos
      trailer = videos.find { |v| v["type"] == "Trailer" && v["site"] == "YouTube" }
      trailer ? "https://www.youtube.com/watch?v=#{trailer['key']}" : nil
    end
  end
end
