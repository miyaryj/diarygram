class InstagramController < ApplicationController
  OAUTH_CALLBACK_URL = 'http://localhost:3000/instagram/callback'

  before_action :sign_in_to_instagram, only: [:index]

  def index
    @instagram_medias = @client.user_recent_media(:self)
  end

  def oauth
    redirect_to(Instagram.authorize_url(redirect_uri: OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: OAUTH_CALLBACK_URL)
    session[:access_token] = response.access_token

    sign_in_to_instagram
    redirect_to(action: :index)
  end

  private

  def sign_in_to_instagram
    return oauth unless session[:access_token]

    @client = Instagram.client(access_token: session[:access_token])
    begin
      @instagram_username = @client.user.username
    rescue Instagram::BadRequest
      return oauth
    end
  end
end
