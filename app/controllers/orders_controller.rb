class OrdersController < ApplicationController
  def index
    @orders = Order.where(customer_id: session[:user]['id'])
  end

  def view
    @order = Order.find_by(id: params[:id])
    @line_items = LineItem.where(order_id: params[:id])
  end
end
