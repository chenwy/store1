class Admin::OrdersController < ApplicationController
  layout 'admin'

  def index
    @orders = Order.all.order("id DESC")
  end

  def shipping
    @order = Order.find(params[:id])
    @order.shipping!
    OrderMailer.notify_order_shipping(@order).deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    OrderMailer.notify_cancel_order(@order).deliver!
    redirect_to :back
  end
end
