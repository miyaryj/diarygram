class InstagramController < ApplicationController
  OAUTH_CALLBACK_URL = 'http://localhost:3000/instagram/callback'

  before_action :sign_in_to_instagram, only: [:index]

  def index
    client = Instagram.client(access_token: session[:access_token])
    user = client.user
    @username = user.username
    @page = client.user_recent_media(:self)
  end

  def oauth
    redirect_to(Instagram.authorize_url(redirect_uri: OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: OAUTH_CALLBACK_URL)
    session[:access_token] = response.access_token
  end

  private

  def sign_in_to_instagram
    oauth unless session[:access_token]
  end
end
