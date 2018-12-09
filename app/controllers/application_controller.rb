# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_guest

  def current_guest
    existing_guest || new_guest
  end

  private

  def existing_guest
    Guest.find(cookies.signed[:guest_id]) if cookies[:guest_id]
  end

  def new_guest
    guest = Guest.create!
    cookies.signed[:guest_id] = { value: guest.id, expires: 1.month.from_now }
    guest
  end
end
