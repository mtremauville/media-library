module Api
  module V1
    class AlbumsController < BaseController
      def show
        service = MusicBrainz::AlbumService.new
        album   = service.find(params[:id])

        if album
          render_success(album)
        else
          render_error("Album non trouvé", status: :not_found)
        end
      end
    end
  end
end
