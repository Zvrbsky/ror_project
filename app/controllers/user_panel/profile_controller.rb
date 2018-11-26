# frozen_string_literal: true

module UserPanel
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def index; end
  end
end
