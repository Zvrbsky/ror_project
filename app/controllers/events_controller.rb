# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy buy]
  before_action :authenticate_host!, except: %i[show index buy]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end


  def edit; end

  def create
    @event = Event.new(event_params)
    @event.host_id = current_host.id
    respond_to do |format|
      if @event.save
        format.html { redirect_to host_panel_root_path, notice: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to host_panel_root_path, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html do
        redirect_to host_panel_root_path, notice:
          'Event was successfully destroyed.'
      end
    end
  end

  def buy
    respond_to do |format|
      if @event.amount == 0
        format.html {redirect_to event_path, notice: 'No tickets available'}
      else
        format.html {redirect_to event_path, notice: 'Ticket was booked successfully'}
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
    params.require(:event).permit(:title, :content, :amount, :event_image, :event_thumb)
  end
end
