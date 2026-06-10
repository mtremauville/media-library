module MusicBrainz
  class AlbumService
    BASE_URL  = "https://musicbrainz.org/ws/2"
    COVER_URL = "https://coverartarchive.org/release"

    def search(query)
      response = HTTParty.get(
        "#{BASE_URL}/release",
        query: { query: query, fmt: "json", limit: 20 },
        headers: { "User-Agent" => ENV["MUSICBRAINZ_USER_AGENT"] },
        timeout: 10
      )
      return [] unless response.success?

      data = JSON.parse(response.body)
      data["releases"].map { |r| format_album(r) }
    end

    def find(mbid)
      response = HTTParty.get(
        "#{BASE_URL}/release/#{mbid}",
        query: { inc: "recordings+artists", fmt: "json" },
        headers: { "User-Agent" => ENV["MUSICBRAINZ_USER_AGENT"] },
        timeout: 10
      )
      return nil unless response.success?

      data = JSON.parse(response.body)
      format_album(data, detailed: true)
    end

    def cover_url(mbid)
      "#{COVER_URL}/#{mbid}/front-250"
    end

    private

    def format_album(data, detailed: false)
      result = {
        external_id:  data["id"],
        title:        data["title"],
        release_date: data.dig("date"),
        media_type:   "album",
        artist:       data.dig("artist-credit", 0, "artist", "name"),
        poster_url:   cover_url(data["id"])
      }

      if detailed && data["media"]
        result[:tracks] = data["media"].flat_map do |medium|
          medium["tracks"]&.map do |t|
            {
              track_number: t["number"].to_i,
              title:        t["title"],
              duration:     t.dig("recording", "length")
            }
          end
        end.compact
      end
      result
    end
  end
end
