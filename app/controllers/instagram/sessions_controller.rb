require 'open-uri'

include InstagramHelper

class Instagram::SessionsController < ApplicationController
  HOSTNAME = ENV['HOSTNAME']
  HOSTNAME ||= 'localhost:3000'
  OAUTH_CALLBACK_URL = "http://#{HOSTNAME}/instagram/sessions/callback"

  before_action :authenticate_user!

  def new
    redirect_to(Instagram.authorize_url(redirect_uri: OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: OAUTH_CALLBACK_URL)
    store_oauth_response(response)

    redirect_back_instagram
  end

  def destroy
    # TODO
    redirect_to instagram_sign_in_path
  end
end
