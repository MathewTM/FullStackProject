class ProductsController < ApplicationController
  def index
    if params[:keyword] != nil then
      @products = Product.where("name LIKE :keyword OR description LIKE :keyword", {:keyword => "%" + params[:keyword] + "%"})
    else
      @products = Product.all
    end
  end

  def view
    @product = Product.find_by(id: params[:id])
  end

  def add_to_cart
    if session[:cart_quantity] then
      session[:cart_quantity] = session[:cart_quantity] + 1
    else
      session[:cart_quantity] = 1
    end

    redirect_to :controller => 'products', :action => 'index'
  end
end
