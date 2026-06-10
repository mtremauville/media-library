module Api
  module V1
    class SeriesController < BaseController
      def show
        service = Tmdb::SeriesService.new
        series  = service.find(params[:id])

        if series
          episodes = []
          if series[:seasons_count]
            (1..series[:seasons_count]).each do |season|
              episodes += service.episodes(params[:id], season)
            end
          end
          render_success(series.merge(episodes: episodes))
        else
          render_error("Série non trouvée", status: :not_found)
        end
      end
    end
  end
end
