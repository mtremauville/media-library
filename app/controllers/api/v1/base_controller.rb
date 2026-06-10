module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { error: e.message }, status: :not_found
      end

      rescue_from ActionController::ParameterMissing do |e|
        render json: { error: e.message }, status: :bad_request
      end

      private

      def render_success(data, status: :ok)
        render json: { success: true, data: data }, status: status
      end

      def render_error(message, status: :unprocessable_entity)
        render json: { success: false, error: message }, status: status
      end
    end
  end
end
