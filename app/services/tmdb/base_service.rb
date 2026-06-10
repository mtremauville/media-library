module Tmdb
  class BaseService
    BASE_URL = "https://api.themoviedb.org/3"
    IMAGE_BASE = "https://image.tmdb.org/t/p/w500"

    private

    def get(endpoint, params = {})
      response = HTTParty.get(
        "#{BASE_URL}#{endpoint}",
        query: params.merge(
          api_key: ENV["TMDB_API_KEY"],
          language: "fr-FR"
        ),
        timeout: 10
      )
      raise "TMDB API Error: #{response.code}" unless response.success?
      JSON.parse(response.body)
    rescue => e
      Rails.logger.error("TMDB Service Error: #{e.message}")
      nil
    end
  end
end
