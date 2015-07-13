include InstagramHelper

class Instagram::MediasController < ApplicationController
  before_action :authenticate_user!
  before_action :sign_in_to_instagram, only: [:index]

  def index
    @instagram_medias = instagram_medias
  end

  def show
    continue_entry_action(instagram_media_id: params[:id])
  end

  private

  def sign_in_to_instagram
    unless signed_in_to_instagram?
      store_location_instagram
      return redirect_to(controller: :sessions, action: :new)
    end
  end
end
