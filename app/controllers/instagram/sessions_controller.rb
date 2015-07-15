include InstagramHelper

class Instagram::SessionsController < ApplicationController
  OAUTH_CALLBACK_URL = 'http://localhost:3000/instagram/sessions/callback'

  before_action :authenticate_user!

  def new
    redirect_to(Instagram.authorize_url(redirect_uri: OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: OAUTH_CALLBACK_URL)
    set_oauth_response(response)

    redirect_back_instagram
  end
end
