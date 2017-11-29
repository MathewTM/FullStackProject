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
    session[:subtotal] = 0
    @cart = fill_cart
  end

  def checkout
    if session[:user].nil?
      session[:redirect] = { controller: 'products', action: 'checkout'}
      redirect_to :controller => 'customers', :action => 'login'
    else
      customer = Customer.find_by(id: session[:user]['id'])
      session[:subtotal] = 0

      @cart = fill_cart
      @pst = session[:subtotal] * customer.province.pst.to_f / 100
      @gst = session[:subtotal] * 0.05
      @total = session[:subtotal] + @pst + @gst
    end
  end

  private
  def fill_cart
    cart = []

    session[:cart].each do |item|
      search = Product.find_by(id: item)
      product = {}
      product[:id] = search.id
      product[:name] = search.name
      product[:price] = search.price
      product[:occurances] = item[1]['occurances']
      cart << product
      session[:subtotal] += search.price * product[:occurances]
    end
    cart
  end
end
