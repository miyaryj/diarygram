require 'instagram'

class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    if params[:start_date].present?
      @date_of_month = Date.parse(params[:start_date])
    else
      @date_of_month = Date.today
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
