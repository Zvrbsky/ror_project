class CartsController < ApplicationController
  def index
    @cart = current_guest.cart
  end

  def confirm
    cart = current_guest.cart
    cart.confirm
    redirect_to user_panel_order_path(cart)
  end
end
