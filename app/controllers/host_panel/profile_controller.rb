# frozen_string_literal: true

module HostPanel
  class ProfileController < ApplicationController
    before_action :authenticate_host!

    def index
      @events = current_host.events
    end
  end
end
