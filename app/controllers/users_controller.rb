class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def oauth
    client_id = ENV['INSTAGRAM_CLIENT_ID']
    client_secret = ENV['INSTAGRAM_CLIENT_SECRET']
    redirect = 'http://localhost:3000/users/callback'
    url = "https://api.instagram.com/oauth/authorize/?client_id=#{client_id}&redirect_uri=#{redirect}&response_type=code"
    redirect_to(url)
  end

  def callback
    @instagram_token = params[:code]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
