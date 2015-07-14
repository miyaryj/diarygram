include EntriesHelper
include InstagramHelper

class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :clear_entry_action, only: [:new, :edit]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    unless params[:instagram_media_id].present?
      store_entry_action(controller: '/entries', action: :new, date: params[:date])
      return redirect_to(instagram_medias_path)
    end

    @entry = Entry.new

    if params[:date].present?
      @date = Date.parse(params[:date])
    else
      @date = Date.today
    end

    @instagram_media_id = params[:instagram_media_id]
    @instagram_media = instagram_media(@instagram_media_id)
  end

  # GET /entries/1/edit
  def edit
    if params[:date].present?
      @date = Date.parse(params[:date])
    else
      @date = Date.parse(@entry.date)
    end

    if params[:instagram_media_id].present?
      @instagram_media_id = params[:instagram_media_id]
    else
      @instagram_media_id = @entry.instagram_media_id
    end
    @instagram_media = instagram_media(@instagram_media_id)
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:text, :date, :user_id, :image_url, :thumbnail_url, :media_url, :instagram_media_id)
    end
end
