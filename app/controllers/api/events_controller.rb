module Api
  class EventsController < ApplicationController
    def index
      provider = EventsProvider.new(params[:search], params[:cat])
      render json: provider.results
    end
  end
end
