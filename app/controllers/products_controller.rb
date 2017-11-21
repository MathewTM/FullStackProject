class ProductsController < ApplicationController

  def index

    if !session[:cart] then
      session[:cart] = Hash.new
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
    if !session[:cart].include? params[:id] then
      session[:cart] = session[:cart].merge!({params[:id] => {"occurances" => 1}})
    else
      session[:cart][params[:id]]["occurances"] += 1
    end

    redirect_to :controller => 'products', :action => 'index'
  end

  def cart
    @cart = Array.new

    session[:cart].each do |item|

      search = Product.find_by(id: item)
      product = Hash.new
      product[:id] = search.id
      product[:name] = search.name
      product[:price] = search.price
      product[:occurances] = item[1]["occurances"]
      @cart << product
    end
  end
end
