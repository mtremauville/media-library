module Api
  module V1
    class MediaItemsController < BaseController
      def index
        @items = current_user.media_items
                             .includes(:episodes, :tracks)
                             .order(created_at: :desc)

        @items = @items.where(media_type: params[:type]) if params[:type].present?
        render_success(@items.as_json(include: [:episodes, :tracks]))
      end

      def show
        @item = current_user.media_items.find(params[:id])
        render_success(@item.as_json(include: [:episodes, :tracks]))
      end

      def create
        @item = current_user.media_items.build(media_item_params)

        if @item.save
          render_success(@item, status: :created)
        else
          render_error(@item.errors.full_messages.join(", "))
        end
      end

      def destroy
        @item = current_user.media_items.find(params[:id])
        @item.destroy
        render_success({ message: "Supprimé avec succès" })
      end

      private

      def media_item_params
        params.require(:media_item).permit(
          :title, :media_type, :external_id, :poster_url,
          :synopsis, :rating, :release_date, metadata: {}
        )
      end
    end
  end
end
