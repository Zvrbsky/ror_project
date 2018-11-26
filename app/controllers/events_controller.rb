# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show buy]

  def index
    @view_model = HomePageViewModel.new
    @events = if (params[:cat].nil? and params[:search].nil?) or (params[:cat].nil? and params[:search] == '')
                Event.all
              elsif params[:cat].nil?
                Event.where("title LIKE '%#{params[:search]}%'")
              elsif params[:search] == ''
                Event.where(category: params[:cat])
              else
                Event.where(category: params[:cat]).where("title LIKE '%#{params[:search]}%'")
              end
    @categories = ['Rock', 'Jazz', 'Pop', 'Punk', 'Hardcore', 'Metal', 'Rave']
  end

  def show; end

  def buy
    respond_to do |format|
      if @event.amount.zero?
        format.html { redirect_to event_path, notice: 'No tickets available' }
      else
        format.html { redirect_to event_path, notice: 'Ticket was booked successfully' }
        @event.amount -= 1
        @event.save
      end
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :content, :amount, :event_image, :date, :search, :cat)
  end

end
