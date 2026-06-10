module Api
  module V1
    class SearchController < BaseController
      def index
        query = params[:q]
        type  = params[:type] || "all"

        return render_error("Requête vide") if query.blank?

        results = {}

        if type.in?(%w[all movie])
          results[:movies] = Tmdb::MovieService.new.search(query)
        end

        if type.in?(%w[all series])
          results[:series] = Tmdb::SeriesService.new.search(query)
        end

        if type.in?(%w[all album])
          results[:albums] = MusicBrainz::AlbumService.new.search(query)
        end

        render_success(results)
      end
    end
  end
end
