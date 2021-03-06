include EntriesHelper
include InstagramHelper

class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
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
    store_entry_action(controller: '/entries', action: :new, date: params[:date])

    @entry = Entry.new

    if params[:instagram_media_id].present?
      @instagram_media_id = params[:instagram_media_id]
      @instagram_media = instagram_media(@instagram_media_id)
      @text = @instagram_media.caption.text if @instagram_media.caption
    end

    if params[:date].present?
      @date = Date.parse(params[:date])
    elsif @instagram_media
      @date = Date.parse(Time.zone.at(@instagram_media.created_time.to_i).to_s)
    else
      @date = Time.zone.today
    end
  end

  # GET /entries/1/edit
  def edit
    if @entry
      date = @entry.date
    else
      date = params[:date]
    end
    store_entry_action(controller: '/entries', action: :edit, id: params[:id], date: date)

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

    if @instagram_media_id
      @instagram_media = instagram_media(@instagram_media_id)
      @text = @instagram_media.caption.text if @instagram_media.caption
    else
      @text = @entry.text
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to user_path(current_user, start_date: @entry.date), notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    if @entry.update(entry_params)
      redirect_to user_path(current_user, start_date: @entry.date), notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    redirect_to user_path(current_user, start_date: @entry.date), notice: 'Entry was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry)
      .permit(:text, :date, :user_id, :image_url, :thumbnail_url, :media_url, :instagram_media_id)
  end

  def correct_user
    redirect_to(root_url) unless @entry.user == current_user
  end

end
