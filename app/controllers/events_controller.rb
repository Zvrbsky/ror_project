# frozen_string_literal: true

require 'uri'

class EventsController < ApplicationController
  before_action :set_event, only: %i[show buy]

  def featured
    @view_model = HomePageViewModel.new
  end

  def index
    @events = Event.all
  end

  def search
    @events = search_events
    @categories = %w[Rock Jazz Pop Punk Hardcore Metal Rave]
  end

  def show; end

  def add_to_cart
    event = Event.find(params[:id])
    outcome = AddToCart.run(guest: current_guest, event: event)

    if outcome.valid?
      flash[:notice] = 'Added to cart'
    else
      flash[:notice] = outcome.errors.full_messages
    end
    redirect_to event_path
  end

  def buy
    if @event.amount.zero?
      flash[:notice] = 'No tickets available'
        redirect_to event_path
    else
      add_to_cart
      @event.amount -= 1
      @event.save
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :content, :amount, :date, :search, :cat, :price)
  end

  def search_events
    @events = filter_events
    @events = @events.where("title LIKE '%#{params[:search]}%'") if params[:search].present?
    @events
  end

  def filter_events
    @events = Event.all
    @events = @events.where(category: params[:cat]) if params[:cat].present?
    @events
  end
end
