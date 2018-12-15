module Api
  class EventsController < ApplicationController
    def index
      provider = EventsProvider.new(params[:key, :cat[]])

      render json: provider.results
    end
  end
end