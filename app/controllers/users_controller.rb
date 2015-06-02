require 'instagram'

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  OAUTH_CALLBACK_URL = 'http://localhost:3000/users/callback'

  def show
  end

  def oauth
    redirect_to(Instagram.authorize_url(:redirect_uri => OAUTH_CALLBACK_URL))
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => OAUTH_CALLBACK_URL)
    session[:access_token] = response.access_token
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
