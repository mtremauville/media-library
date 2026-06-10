# app/controllers/api/v1/movies_controller.rb
module Api
  module V1
    class MoviesController < BaseController
      def show
        service = Tmdb::MovieService.new
        movie   = service.find(params[:id])

        if movie
          render_success(movie)
        else
          render_error("Film non trouvé", status: :not_found)
        end
      end
    end
  end
end
