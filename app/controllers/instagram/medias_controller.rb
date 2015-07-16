include InstagramHelper

class Instagram::MediasController < ApplicationController
  before_action :authenticate_user!
  before_action :sign_in_to_instagram, only: [:index]
  before_action :validate_user, only: [:index]

  def index
    @instagram_medias = instagram_medias
  end

  def show
    continue_entry_action(instagram_media_id: params[:id])
  end

  private

  def sign_in_to_instagram
    return if signed_in_to_instagram?

    store_location_instagram
    redirect_to(controller: :sessions, action: :new)
  end

  def validate_user
    if current_user.instagram_user.present?
      unless current_user.instagram_user.instagram_user_id == oauth_user.id
        store_location_instagram
        return redirect_to(controller: :users, action: :edit)
      end
    else
      store_location_instagram
      return redirect_to(controller: :users, action: :new)
    end
  end
end
