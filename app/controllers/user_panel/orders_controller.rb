module UserPanel
  class OrdersController < ApplicationController
    before_action :authenticate_user!

    def show
      attach_order_to_user
    end

    def index
      @orders = current_user.orders
    end

    def confirm
      @order = current_user.orders.pending.find(params[:id])
      @order.update status: Order::COMPLETE_STATUS
      redirect_to user_panel_order_path(@order)
    end

    private

    def attach_order_to_user
      @order = current_user.orders.find_by(id: params[:id])
      return @order if @order.present?

      @order = current_guest.orders.find_by(id: params[:id])

      raise ActiveRecord::RecordNotFound unless @order.present?

      do_attachment
    end

    def do_attachment
      if Event.decrease_ticket_number(@order)
        @order.update owner: current_user
      else
        flash[:notice] = 'No tickets available'
        @order.destroy
        redirect_to user_panel_orders_path(current_user)
      end
    end
  end
end
