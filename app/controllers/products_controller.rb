class ProductsController < ApplicationController

  def index

    if !session[:cart] then
      session[:cart] = Array.new
    end

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
    session[:cart] << params[:id]

    redirect_to :controller => 'products', :action => 'index'
  end
end
