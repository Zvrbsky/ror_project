# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show buy]

  def index
    @view_model = HomePageViewModel.new
    @events = Event.filter(params[:cat]).search(params[:search])
  end

  def show; end

  def buy
    respond_to do |format|
      if @event.amount == 0
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
