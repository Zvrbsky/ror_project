# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show buy]

  def index
    @view_model = HomePageViewModel.new
    @events = search_events
    @categories = %w[Rock Jazz Pop Punk Hardcore Metal Rave]
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

  def search_events
    @events = filter_events
    @events = @events.where("title LIKE '%#{params[:search]}%'") if params[:search].present? && params[:search] != ''
    @events
  end

  def filter_events
    @events = Event.all
    @events = @events.where(category: params[:cat]) if params[:cat].present?
    @events
  end
end
