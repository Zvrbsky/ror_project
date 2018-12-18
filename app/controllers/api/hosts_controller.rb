module Api
  class HostsController < ApplicationController
    def email_exists
      render json: Host.where(email: params[:email]).exists?
    end
  end
end
