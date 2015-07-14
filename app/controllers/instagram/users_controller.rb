class Instagram::UsersController < ApplicationController
  before_action :set_instagram_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :sign_in_to_instagram, only: [:new]

  def new
    @instagram_user = current_user.build_instagram_user

    user = get_oauth_user
    @instagram_user.instagram_user_id = user.id
    @instagram_user.name = user.username
    @instagram_user.profile_image_url = user.profile_picture
  end

  # GET /instagram/users/1/edit
  def edit
  end

  # POST /instagram/users
  # POST /instagram/users.json
  def create
    @instagram_user = Instagram::User.new(instagram_user_params)

    if @instagram_user.save
      redirect_back_instagram
    else
      render :new
    end
  end

  # PATCH/PUT /instagram/users/1
  # PATCH/PUT /instagram/users/1.json
  def update
    respond_to do |format|
      if @instagram_user.update(instagram_user_params)
        format.html { redirect_to @instagram_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @instagram_user }
      else
        format.html { render :edit }
        format.json { render json: @instagram_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instagram/users/1
  # DELETE /instagram/users/1.json
  def destroy
    @instagram_user.destroy
    respond_to do |format|
      format.html { redirect_to instagram_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_instagram_user
    @instagram_user = Instagram::User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def instagram_user_params
    p params
    params.require(:instagram_user).permit(:name, :user_id, :instagram_user_id, :profile_image_url)
  end

  def sign_in_to_instagram
    unless signed_in_to_instagram?
      return redirect_to(controller: :sessions, action: :new)
    end
  end
end
