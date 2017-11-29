class ProductsController < ApplicationController
  def index
    if !params[:keyword].nil?
      kw = '%' + params[:keyword] + '%'
      @products = Product.where('name LIKE :kw OR description LIKE :kw', :kw => kw)
    else
      @products = Product.all
    end
  end

  def view
    @product = Product.find_by(id: params[:id])
  end

  def add_to_cart
    unless session[:cart] then session[:cart] = {} end

    if !session[:cart].include? params[:id]
      session[:cart] = session[:cart].merge!(params[:id] => { 'occurances' => 1 })
    else
      session[:cart][params[:id]]['occurances'] += 1
    end

    redirect_to :controller => 'products', :action => 'index'
  end

  def cart
    @subtotal = 0
    @cart = []

    session[:cart].each do |item|
      search = Product.find_by(id: item)
      product = {}
      product[:id] = search.id
      product[:name] = search.name
      product[:price] = search.price
      product[:occurances] = item[1]['occurances']
      @cart << product
      @subtotal += search.price * 100 * product[:occurances]
    end
  end
end
