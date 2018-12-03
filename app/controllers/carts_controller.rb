class CartsController < ApplicationController
  def index
    @cart = current_guest.cart
  end
end
