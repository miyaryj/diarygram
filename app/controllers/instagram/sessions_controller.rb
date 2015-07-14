include InstagramHelper

class Instagram::SessionsController < ApplicationController
  OAUTH_CALLBACK_URL = 'http://localhost:3000/instagram/sessions/callback'

  before_action :authenticate_user!

  def new
    redirect_to(Instagram.authorize_url(redirect_uri: OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: OAUTH_CALLBACK_URL)

    p current_user
    if current_user.instagram_user.present? && current_user.instagram_user.instagram_user_id == response.user.id
      set_access_token(response.access_token)
    else
      set_oauth_response(response)
      redirect_to(controller: :users, action: :new)
    end

    sign_in_to_instagram
    redirect_back_instagram
  end

end
