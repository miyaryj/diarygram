include InstagramHelper

class InstagramController < ApplicationController
  OAUTH_CALLBACK_URL = 'http://localhost:3000/instagram/callback'

  before_action :sign_in_to_instagram, only: [:index]

  def index
    @instagram_medias = instagram_medias
  end

  def oauth
    redirect_to(Instagram.authorize_url(redirect_uri: OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: OAUTH_CALLBACK_URL)
    session[:access_token] = response.access_token

    sign_in_to_instagram
    redirect_back_instagram
  end

  private

  def sign_in_to_instagram
    unless signed_in_to_instagram?
      store_location_instagram
      return oauth unless session[:access_token]
    end
  end
end
