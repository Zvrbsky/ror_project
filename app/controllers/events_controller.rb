# frozen_string_literal: true

require 'uri'

class EventsController < ApplicationController
  before_action :set_event, only: %i[show buy add_to_cart]

  def featured
    @view_model = HomePageViewModel.new
  end

  def index
    @events = Event.all
  end

  def search
    @events = EventsProvider.new(params[:search], params[:cat]).results
    @categories = %w[Rock Jazz Pop Punk Hardcore Metal Rave]
  end

  def show; end

  def add_to_cart
    outcome = AddToCart.run(guest: current_guest, event: @event)

    flash[:notice] = if outcome.valid?
                       'Added to cart'
                     else
                       outcome.errors.full_messages
                     end
    redirect_to event_path
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
