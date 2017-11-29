class OrdersController < ApplicationController
  def index
    @orders = Order.where(customer_id: session[:user]['id'])
  end

  def view
    @line_items = LineItem.where(order_id: params[:order_id])
  end
end
