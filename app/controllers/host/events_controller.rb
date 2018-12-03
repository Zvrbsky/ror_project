# frozen_string_literal: true

class Host::EventsController < ApplicationController
  before_action :set_event, only: %i[edit update destroy]
  before_action :authenticate_host!

  def create
    @event = Event.new(event_params)
    @event.host_id = current_host.id
    respond_to do |format|
      if @event.save
        if !@event.event_image.attached?
          file = open(URI.parse('http://oliclinic.pl/wp-content/uploads/2016/10/orionthemes-placeholder-image.png'))
          @event.event_image.attach(io: file, filename: 'dummy.png')
          @event.save
        end
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

  def new
    @event = Event.new
  end

  def edit
    @event = current_host.events.find(params[:id])
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :content, :amount, :event_image, :date, :search, :cat)
  end
end
