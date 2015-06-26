require 'instagram'

include ApplicationHelper
include EntriesHelper

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def timeline
    current_tab(:timeline)

    @entries = current_user.timeline_entries.limit(10)
  end

  def show
    current_tab(:calendar)

    if params[:start_date].present?
      date_of_month = Date.parse(params[:start_date])
    else
      date_of_month = Date.today
    end

    @entries = entries_of_month(@user, date_of_month)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
