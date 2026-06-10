class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  private

  def current_user_id
    current_user&.id
  end
end
