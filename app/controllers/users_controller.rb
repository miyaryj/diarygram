require 'instagram'

include ApplicationHelper
include EntriesHelper

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :following, :followers]

  def timeline
    current_tab(:timeline)

    @entries = current_user.timeline_entries.paginate(page: params[:page])
  end

  def account
    current_tab(:account)
  end

  def show
    current_tab(:calendar)

    if params[:start_date].present?
      date_of_month = Date.parse(params[:start_date])
    else
      date_of_month = Time.zone.today
    end

    @entries = entries_of_month(@user, date_of_month)
  end

  def following
    @title = "Following"
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
