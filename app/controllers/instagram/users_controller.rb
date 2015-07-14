class Instagram::UsersController < ApplicationController
  before_action :set_instagram_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :sign_in_to_instagram, only: [:index]

  def new
    @instagram_user = Instagram::User.new

    user = Hashie.new(get_oauth_response['user'])
    @instagram_user.user_id = current_user.id
    @instagram_user.instagram_user_id = user.id
    @instagram_user.instagram_user_id = user.id
    @instagram_user.instagram_user_id = user.id
  end

  # GET /instagram/users/1/edit
  def edit
  end

  # POST /instagram/users
  # POST /instagram/users.json
  def create
    @instagram_user = Instagram::User.new(instagram_user_params)

    respond_to do |format|
      if @instagram_user.save
        format.html { redirect_to @instagram_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @instagram_user }
      else
        format.html { render :new }
        format.json { render json: @instagram_user.errors, status: :unprocessable_entity }
      end
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
      params.require(:instagram_user).permit(:name, :user_id, :instagram_user_id, :profile_image_url)
    end
end
